import 'package:cloud_firestore/cloud_firestore.dart';
import 'attachment_model.dart';

class NoteModel {
  final String id;
  final String title;
  final String content;
  final String subject;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<AttachmentModel> attachments;

  const NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.subject,
    required this.createdAt,
    required this.updatedAt,
    this.attachments = const [],
  });

  factory NoteModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final attachmentsData = data['attachments'] as List<dynamic>? ?? [];
    return NoteModel(
      id: doc.id,
      title: data['title'] as String? ?? '',
      content: data['content'] as String? ?? '',
      subject: data['subject'] as String? ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      attachments: attachmentsData
          .map((a) => AttachmentModel.fromMap(a as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'content': content,
      'subject': subject,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'attachments': attachments.map((a) => a.toMap()).toList(),
    };
  }

  String get preview {
    final singleLine = content.replaceAll('\n', ' ').trim();
    return singleLine.length > 100 ? '${singleLine.substring(0, 100)}...' : singleLine;
  }
}