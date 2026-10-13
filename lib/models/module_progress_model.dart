import 'package:cloud_firestore/cloud_firestore.dart';

/// Tracks a student's manual progress through a subject's syllabus
/// (e.g. "7 of 12 topics covered"). Stored at
/// users/{uid}/progress/{progressId}, one document per subject.
class ModuleProgressModel {
  final String id;
  final String subject;
  final int totalTopics;
  final int completedTopics;

  const ModuleProgressModel({
    required this.id,
    required this.subject,
    required this.totalTopics,
    required this.completedTopics,
  });

  double get percentage {
    if (totalTopics == 0) return 0.0;
    return (completedTopics / totalTopics) * 100;
  }

  factory ModuleProgressModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ModuleProgressModel(
      id: doc.id,
      subject: data['subject'] as String? ?? '',
      totalTopics: data['totalTopics'] as int? ?? 1,
      completedTopics: data['completedTopics'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'subject': subject,
      'totalTopics': totalTopics,
      'completedTopics': completedTopics,
    };
  }

  ModuleProgressModel copyWith({int? completedTopics, int? totalTopics}) {
    return ModuleProgressModel(
      id: id,
      subject: subject,
      totalTopics: totalTopics ?? this.totalTopics,
      completedTopics: completedTopics ?? this.completedTopics,
    );
  }
}