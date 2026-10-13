import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/task_model.dart';
import '../../models/attachment_model.dart';

class TaskService {
  CollectionReference _tasksRef(String uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('tasks');
  }

  Stream<List<TaskModel>> watchTasks(String uid) {
    return _tasksRef(uid).snapshots().map((snapshot) {
      final tasks =
          snapshot.docs.map((doc) => TaskModel.fromFirestore(doc)).toList();

      tasks.sort((a, b) {
        if (a.isCompleted != b.isCompleted) {
          return a.isCompleted ? 1 : -1;
        }
        if (a.dueDate == null && b.dueDate == null) return 0;
        if (a.dueDate == null) return 1;
        if (b.dueDate == null) return -1;
        return a.dueDate!.compareTo(b.dueDate!);
      });

      return tasks;
    });
  }

  /// Reserves a Firestore document ID WITHOUT writing anything.
  /// This lets the form copy attachment files into
  /// attachments/tasks/{id}/ first, then save the task and its
  /// attachment list together in ONE write.
  String newId(String uid) => _tasksRef(uid).doc().id;

  /// Create-or-update in a single write (the task's [TaskModel.id]
  /// must already be set — see [newId]). The attachments list is part
  /// of the same document write, so a task can never be saved without
  /// its attachments (or vice versa).
  ///
  /// Firestore queues writes locally when the device is offline and
  /// the returned Future then waits for the server, which could hang
  /// forever with no connection — so after [_serverAckTimeout] we
  /// treat the write as accepted (it is already in the local cache
  /// and will sync automatically).
  Future<void> saveTask(String uid, TaskModel task) async {
    await _tasksRef(uid)
        .doc(task.id)
        .set(task.toFirestore(), SetOptions(merge: true))
        .timeout(_serverAckTimeout, onTimeout: () {});
  }

  static const Duration _serverAckTimeout = Duration(seconds: 8);

  Future<String> addTask(String uid, TaskModel task) async {
    final docRef = await _tasksRef(uid).add(task.toFirestore());
    return docRef.id;
  }

  Future<void> updateTask(String uid, TaskModel task) async {
    await _tasksRef(uid).doc(task.id).update(task.toFirestore());
  }

  Future<void> deleteTask(String uid, String taskId) async {
    await _tasksRef(uid).doc(taskId).delete();
  }

  Future<void> toggleComplete(String uid, String taskId, bool isCompleted) async {
    await _tasksRef(uid).doc(taskId).update({'isCompleted': isCompleted});
  }

  Future<void> updateAttachments(
    String uid,
    String taskId,
    List<AttachmentModel> attachments,
  ) async {
    await _tasksRef(uid).doc(taskId).update({
      'attachments': attachments.map((a) => a.toMap()).toList(),
    });
  }
}