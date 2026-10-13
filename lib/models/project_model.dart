import 'package:cloud_firestore/cloud_firestore.dart';
import '../l10n/app_localizations.dart';
import 'attachment_model.dart';

enum ProjectStatus { ongoing, pending, completed, cancelled }

class ProjectModel {
  final String id;
  final String title;
  final String description;
  final ProjectStatus status;
  final DateTime? dueDate;
  final DateTime createdAt;
  final List<AttachmentModel> attachments;

  const ProjectModel({
    required this.id,
    required this.title,
    this.description = '',
    required this.status,
    this.dueDate,
    required this.createdAt,
    this.attachments = const [],
  });

  factory ProjectModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final attachmentsData = data['attachments'] as List<dynamic>? ?? [];
    return ProjectModel(
      id: doc.id,
      title: data['title'] as String? ?? '',
      description: data['description'] as String? ?? '',
      status: ProjectStatus.values[data['status'] as int? ?? 0],
      dueDate: (data['dueDate'] as Timestamp?)?.toDate(),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      attachments: attachmentsData
          .map((a) => AttachmentModel.fromMap(a as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'status': status.index,
      'dueDate': dueDate != null ? Timestamp.fromDate(dueDate!) : null,
      'createdAt': Timestamp.fromDate(createdAt),
      'attachments': attachments.map((a) => a.toMap()).toList(),
    };
  }

  ProjectModel copyWith({
    String? title,
    String? description,
    ProjectStatus? status,
    DateTime? dueDate,
    List<AttachmentModel>? attachments,
  }) {
    return ProjectModel(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      dueDate: dueDate ?? this.dueDate,
      createdAt: createdAt,
      attachments: attachments ?? this.attachments,
    );
  }
}

extension ProjectStatusDisplay on ProjectStatus {
  String label(AppLocalizations l10n) {
    switch (this) {
      case ProjectStatus.ongoing:
        return l10n.projectStatusOngoing;
      case ProjectStatus.pending:
        return l10n.projectStatusPending;
      case ProjectStatus.completed:
        return l10n.projectStatusCompleted;
      case ProjectStatus.cancelled:
        return l10n.projectStatusCancelled;
    }
  }
}