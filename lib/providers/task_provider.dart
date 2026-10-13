import 'dart:async';
import 'package:flutter/foundation.dart';
import '../core/services/task_service.dart';
import '../core/services/notification_service.dart';
import '../models/task_model.dart';
import '../models/attachment_model.dart';

class TaskProvider extends ChangeNotifier {
  final TaskService _service = TaskService();

  StreamSubscription<List<TaskModel>>? _subscription;
  List<TaskModel> _tasks = [];
  String? _currentUid;
  bool _isLoading = false;
  String? _errorMessage;
  String? _warningMessage;

  List<TaskModel> get tasks => _tasks;
  bool get isLoading => _isLoading;

  /// Set only when something actually FAILED to save.
  String? get errorMessage => _errorMessage;

  /// Set when the task WAS saved but a secondary step (the reminder
  /// notification) had a problem. Never means data was lost.
  String? get warningMessage => _warningMessage;

  List<TaskModel> get pendingTasks => _tasks.where((t) => !t.isCompleted).toList();
  List<TaskModel> get completedTasks => _tasks.where((t) => t.isCompleted).toList();

  int get pendingCount => pendingTasks.length;
  int get overdueCount => _tasks.where((t) => t.isOverdue).length;

  void updateAuthUid(String? uid) {
    if (uid == _currentUid) return;
    _currentUid = uid;
    _subscription?.cancel();

    if (uid == null) {
      _tasks = [];
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    _subscription = _service.watchTasks(uid).listen(
      (tasks) {
        _tasks = tasks;
        _isLoading = false;
        notifyListeners();
      },
      onError: (error) {
        _errorMessage = 'Failed to load tasks: $error';
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  /// Combines dueDate + dueTimeMinutes into a DateTime for reminder
  /// scheduling. If no specific time was set, defaults to 9:00 AM —
  /// a reminder offset needs SOME concrete time to count back from.
  DateTime? _dueDateTimeFor(TaskModel task) {
    if (task.dueDate == null) return null;
    final timeMinutes = task.dueTimeMinutes ?? (9 * 60);
    return DateTime(
      task.dueDate!.year, task.dueDate!.month, task.dueDate!.day,
      timeMinutes ~/ 60, timeMinutes % 60,
    );
  }

  /// Schedules (or cancels) the reminder notification for a task.
  ///
  /// IMPORTANT: this is deliberately NON-FATAL. It runs only AFTER the
  /// task has already been written to Firestore, never throws, and
  /// never blocks for long. Previously a notification/permission
  /// problem here threw inside the same try/catch as the save, which
  /// made the whole operation report failure and skipped saving the
  /// attachments — that is why Tasks/Calendar lost data while Notes
  /// (which has no reminders) did not.
  Future<void> _scheduleReminderSafely(String taskId, TaskModel task) async {
    try {
      await _scheduleReminderFor(taskId, task)
          .timeout(const Duration(seconds: 6), onTimeout: () {});
    } catch (e) {
      _warningMessage = 'Task saved, but the reminder could not be scheduled.';
      if (kDebugMode) debugPrint('[TaskProvider] reminder scheduling failed: $e');
    }
  }

  Future<void> _scheduleReminderFor(String taskId, TaskModel task) async {
    final dueDateTime = _dueDateTimeFor(task);
    if (dueDateTime == null || task.isCompleted) {
      await NotificationService().cancelOffsetReminder(taskId);
      return;
    }
    await NotificationService().requestPermission();
    await NotificationService().scheduleOffsetReminder(
      id: taskId,
      title: 'Task due: ${task.title}',
      body: task.description.isNotEmpty ? task.description : 'Tap to view details',
      targetDateTime: dueDateTime,
      offsetMinutes: task.reminderOffsetMinutes,
    );

    if (task.reminderOffsetMinutes != null &&
        !await NotificationService().canScheduleExactAlarms()) {
      _warningMessage =
          'Reminder saved, but exact alarms are disabled in system settings — it may fire late.';
    }
  }

  /// Reserves a new task ID (no write happens). Returns null if no
  /// user is signed in.
  String? generateTaskId() {
    if (_currentUid == null) return null;
    return _service.newId(_currentUid!);
  }

  /// THE save method used by the task form. Creates or updates the
  /// task AND its attachment list in a single Firestore write, then
  /// schedules the reminder as a separate, non-fatal step.
  ///
  /// [task.id] must already be set (use [generateTaskId] for new tasks).
  /// Returns true only if the task was actually saved.
  Future<bool> saveTask(TaskModel task) async {
    if (_currentUid == null) {
      _errorMessage = 'Not signed in — cannot save task.';
      notifyListeners();
      return false;
    }
    _errorMessage = null;
    _warningMessage = null;
    try {
      await _service.saveTask(_currentUid!, task);
    } catch (e) {
      _errorMessage = 'Failed to save task: $e';
      notifyListeners();
      return false;
    }
    await _scheduleReminderSafely(task.id, task);
    return true;
  }

  Future<String?> addTask(TaskModel task) async {
    if (_currentUid == null) return null;
    _errorMessage = null;
    _warningMessage = null;
    final String id;
    try {
      id = await _service.addTask(_currentUid!, task);
    } catch (e) {
      _errorMessage = 'Failed to add task: $e';
      notifyListeners();
      return null;
    }
    await _scheduleReminderSafely(id, task);
    return id;
  }

  Future<bool> updateTask(TaskModel task) async {
    if (_currentUid == null) return false;
    _errorMessage = null;
    _warningMessage = null;
    try {
      await _service.updateTask(_currentUid!, task);
    } catch (e) {
      _errorMessage = 'Failed to update task: $e';
      notifyListeners();
      return false;
    }
    await _scheduleReminderSafely(task.id, task);
    return true;
  }

  Future<bool> deleteTask(String taskId) async {
    if (_currentUid == null) return false;
    try {
      await _service.deleteTask(_currentUid!, taskId);
    } catch (e) {
      _errorMessage = 'Failed to delete task: $e';
      notifyListeners();
      return false;
    }
    try {
      await NotificationService().cancelOffsetReminder(taskId);
    } catch (_) {
      // Task is already deleted; a stale reminder is not worth failing over.
    }
    return true;
  }

  Future<void> toggleComplete(TaskModel task) async {
    if (_currentUid == null) return;
    final index = _tasks.indexWhere((t) => t.id == task.id);
    final updated = task.copyWith(isCompleted: !task.isCompleted);
    if (index != -1) {
      _tasks[index] = updated;
      notifyListeners();
    }
    try {
      await _service.toggleComplete(_currentUid!, task.id, updated.isCompleted);
    } catch (e) {
      _errorMessage = 'Failed to update task: $e';
      notifyListeners();
      return;
    }
    // Cancel the reminder once a task is marked done (nothing to be
    // reminded about); re-schedule it if un-completed again.
    await _scheduleReminderSafely(task.id, updated);
  }

  Future<bool> persistAttachments(String taskId, List<AttachmentModel> attachments) async {
    if (_currentUid == null) return false;
    try {
      await _service.updateAttachments(_currentUid!, taskId, attachments);
      return true;
    } catch (e) {
      _errorMessage = 'Failed to update attachments: $e';
      notifyListeners();
      return false;
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}