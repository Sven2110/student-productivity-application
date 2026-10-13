/// Represents an authenticated student in the app.
/// This is a plain Dart model, independent of Firebase, so the rest
/// of the app doesn't need to import firebase_auth directly.
/// Any additional profile fields backed by Firestore (e.g., year or
/// major) should be added here rather than scattered throughout the UI.
class UserModel {
  final String uid;
  final String email;
  final String? displayName;

  const UserModel({
    required this.uid,
    required this.email,
    this.displayName,
  });

  /// Converts a Firebase User object into our app's UserModel.
  /// This is the ONLY place in the app that should know about
  /// Firebase's User shape — everything else uses UserModel.
  factory UserModel.fromFirebaseUser(dynamic firebaseUser) {
    return UserModel(
      uid: firebaseUser.uid as String,
      email: firebaseUser.email as String? ?? '',
      displayName: firebaseUser.displayName as String?,
    );
  }
}