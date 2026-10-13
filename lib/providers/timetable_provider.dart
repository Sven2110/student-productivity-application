import 'dart:async';
import 'package:flutter/foundation.dart';
import '../core/services/timetable_service.dart';
import '../core/services/notification_service.dart';
import '../models/timetable_entry_model.dart';

class TimetableProvider extends ChangeNotifier {
  final TimetableService _service = TimetableService();

  StreamSubscription<List<TimetableEntryModel>>? _subscription;
  List<TimetableEntryModel> _entries = [];
  String? _currentUid;
  bool _isLoading = false;
  String? _errorMessage;
  bool _hasScheduledInitialReminders = false;

  List<TimetableEntryModel> get entries => _entries;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  List<TimetableEntryModel> entriesForDay(int dayOfWeek) {
    return _entries.where((e) => e.dayOfWeek == dayOfWeek).toList();
  }

  void updateAuthUid(String? uid) {
    if (uid == _currentUid) return;
    _currentUid = uid;
    _hasScheduledInitialReminders = false;
    _subscription?.cancel();

    if (uid == null) {
      _entries = [];
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    _subscription = _service.watchEntries(uid).listen(
      (entries) async {
        _entries = entries;
        _isLoading = false;
        notifyListeners();

        if (!_hasScheduledInitialReminders) {
          _hasScheduledInitialReminders = true;
          for (final entry in entries) {
            await NotificationService().scheduleReminderForEntry(entry);
          }
        }
      },
      onError: (error) {
        _errorMessage = 'Failed to load timetable: $error';
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<bool> addEntry(TimetableEntryModel entry) async {
    if (_currentUid == null) return false;
    _errorMessage = null;
    try {
      final newId = await _service.addEntry(_currentUid!, entry);

      // Re-request permission right before scheduling — cheap and
      // idempotent, and guards against the case where the user
      // granted/revoked permission in system settings mid-session.
      await NotificationService().requestPermission();

      final scheduledEntry = TimetableEntryModel(
        id: newId,
        subject: entry.subject,
        location: entry.location,
        dayOfWeek: entry.dayOfWeek,
        startMinutes: entry.startMinutes,
        endMinutes: entry.endMinutes,
        colorValue: entry.colorValue,
        reminderOffsetMinutes: entry.reminderOffsetMinutes,
      );
      await NotificationService().scheduleReminderForEntry(scheduledEntry);
      await _warnIfExactAlarmsUnavailable(entry.reminderOffsetMinutes);

      return true;
    } catch (e) {
      _errorMessage = 'Failed to add entry: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateEntry(TimetableEntryModel entry) async {
    if (_currentUid == null) return false;
    _errorMessage = null;
    try {
      await _service.updateEntry(_currentUid!, entry);
      await NotificationService().requestPermission();
      await NotificationService().scheduleReminderForEntry(entry);
      await _warnIfExactAlarmsUnavailable(entry.reminderOffsetMinutes);
      return true;
    } catch (e) {
      _errorMessage = 'Failed to update entry: $e';
      notifyListeners();
      return false;
    }
  }

  Future<void> _warnIfExactAlarmsUnavailable(int? reminderOffsetMinutes) async {
    if (reminderOffsetMinutes != null &&
        !await NotificationService().canScheduleExactAlarms()) {
      _errorMessage =
          'Reminder saved, but exact alarms are disabled in system settings — it may fire late.';
      notifyListeners();
    }
  }

  Future<bool> deleteEntry(String entryId) async {
    if (_currentUid == null) return false;
    try {
      await _service.deleteEntry(_currentUid!, entryId);
      await NotificationService().cancelReminderForEntry(entryId);
      return true;
    } catch (e) {
      _errorMessage = 'Failed to delete entry: $e';
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