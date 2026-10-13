import 'package:cloud_firestore/cloud_firestore.dart';
import 'attachment_model.dart';

enum TaskPriority { low, medium, high }

class TaskModel {
  final String id;
  final String title;
  final String description;
  final DateTime? dueDate;
  /// Minutes since midnight for the due TIME, if the student set
  /// one — null means "due date only, no specific time". A reminder
  /// offset requires a concrete time to count back from, so if this
  /// is null but a reminder is set, 9:00 AM is used as a sensible
  /// default (see TaskProvider).
  final int? dueTimeMinutes;
  final TaskPriority priority;
  final bool isCompleted;
  final DateTime createdAt;
  final List<AttachmentModel> attachments;
  final int? reminderOffsetMinutes;

  const TaskModel({
    required this.id,
    required this.title,
    this.description = '',
    this.dueDate,
    this.dueTimeMinutes,
    this.priority = TaskPriority.medium,
    this.isCompleted = false,
    required this.createdAt,
    this.attachments = const [],
    this.reminderOffsetMinutes,
  });

  bool get isOverdue =>
      !isCompleted && dueDate != null && dueDate!.isBefore(DateTime.now());

  factory TaskModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final attachmentsData = data['attachments'] as List<dynamic>? ?? [];
    return TaskModel(
      id: doc.id,
      title: data['title'] as String? ?? '',
      description: data['description'] as String? ?? '',
      dueDate: (data['dueDate'] as Timestamp?)?.toDate(),
      dueTimeMinutes: data['dueTimeMinutes'] as int?,
      priority: TaskPriority.values[data['priority'] as int? ?? 1],
      isCompleted: data['isCompleted'] as bool? ?? false,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      attachments: attachmentsData
          .map((a) => AttachmentModel.fromMap(a as Map<String, dynamic>))
          .toList(),
      reminderOffsetMinutes: data['reminderOffsetMinutes'] as int?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'dueDate': dueDate != null ? Timestamp.fromDate(dueDate!) : null,
      'dueTimeMinutes': dueTimeMinutes,
      'priority': priority.index,
      'isCompleted': isCompleted,
      'createdAt': Timestamp.fromDate(createdAt),
      'attachments': attachments.map((a) => a.toMap()).toList(),
      'reminderOffsetMinutes': reminderOffsetMinutes,
    };
  }

  TaskModel copyWith({
    String? title,
    String? description,
    DateTime? dueDate,
    int? dueTimeMinutes,
    TaskPriority? priority,
    bool? isCompleted,
    List<AttachmentModel>? attachments,
    int? reminderOffsetMinutes,
  }) {
    return TaskModel(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      dueTimeMinutes: dueTimeMinutes ?? this.dueTimeMinutes,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt,
      attachments: attachments ?? this.attachments,
      reminderOffsetMinutes: reminderOffsetMinutes ?? this.reminderOffsetMinutes,
    );
  }
}