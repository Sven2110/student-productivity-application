import 'package:cloud_firestore/cloud_firestore.dart';

class StudentProfileModel {
  final String uid;
  final String email;
  final String fullName;
  final String studentId;
  final String course;
  final int yearOfStudy;
  /// Absolute local file path on THIS device — not a remote URL.
  /// See LocalStorageService for why this is device-local only.
  final String? profileImagePath;
  final DateTime? createdAt;

  const StudentProfileModel({
    required this.uid,
    required this.email,
    this.fullName = '',
    this.studentId = '',
    this.course = '',
    this.yearOfStudy = 1,
    this.profileImagePath,
    this.createdAt,
  });

  factory StudentProfileModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return StudentProfileModel(
      uid: doc.id,
      email: data['email'] as String? ?? '',
      fullName: data['fullName'] as String? ?? '',
      studentId: data['studentId'] as String? ?? '',
      course: data['course'] as String? ?? '',
      yearOfStudy: data['yearOfStudy'] as int? ?? 1,
      profileImagePath: data['profileImagePath'] as String?,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toFirestoreUpdate() {
    return {
      'email': email,
      'fullName': fullName,
      'studentId': studentId,
      'course': course,
      'yearOfStudy': yearOfStudy,
      'profileImagePath': profileImagePath,
    };
  }

  StudentProfileModel copyWith({
    String? fullName,
    String? studentId,
    String? course,
    int? yearOfStudy,
    String? profileImagePath,
  }) {
    return StudentProfileModel(
      uid: uid,
      email: email,
      fullName: fullName ?? this.fullName,
      studentId: studentId ?? this.studentId,
      course: course ?? this.course,
      yearOfStudy: yearOfStudy ?? this.yearOfStudy,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      createdAt: createdAt,
    );
  }
}