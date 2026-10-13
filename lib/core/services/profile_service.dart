import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/student_profile_model.dart';

class ProfileService {
  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection('users');

  Future<void> createInitialProfile({
    required String uid,
    required String email,
  }) async {
    await _usersRef.doc(uid).set({
      'email': email,
      'fullName': '',
      'studentId': '',
      'course': '',
      'yearOfStudy': 1,
      'profileImageUrl': null,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  /// Checks whether a profile document already exists for this user,
  /// and creates a default one if not. This handles accounts that
  /// were registered before profile creation existed in the app
  /// (or any future case where a profile doc is unexpectedly missing),
  /// so login always "heals" the account into a valid state.
  Future<void> ensureProfileExists({
    required String uid,
    required String email,
  }) async {
    final doc = await _usersRef.doc(uid).get();
    if (!doc.exists) {
      await createInitialProfile(uid: uid, email: email);
    }
  }

  Stream<StudentProfileModel?> watchProfile(String uid) {
    return _usersRef.doc(uid).snapshots().map((doc) {
      if (!doc.exists) return null;
      return StudentProfileModel.fromFirestore(doc);
    });
  }

  Future<void> updateProfile(StudentProfileModel profile) async {
    await _usersRef.doc(profile.uid).update(profile.toFirestoreUpdate());
  }
}