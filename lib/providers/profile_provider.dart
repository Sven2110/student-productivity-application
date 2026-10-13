import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import '../core/services/profile_service.dart';
import '../core/services/local_storage_service.dart';
import '../models/student_profile_model.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileService _profileService = ProfileService();
  final LocalStorageService _localStorageService = LocalStorageService();

  StreamSubscription<StudentProfileModel?>? _subscription;
  StudentProfileModel? _profile;
  String? _currentUid;
  bool _isLoading = false;
  String? _errorMessage;

  StudentProfileModel? get profile => _profile;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void updateAuthUid(String? uid) {
    if (uid == _currentUid) return;
    _currentUid = uid;

    _subscription?.cancel();

    if (uid == null) {
      _profile = null;
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    _subscription = _profileService.watchProfile(uid).listen(
      (profile) {
        _profile = profile;
        _isLoading = false;
        notifyListeners();
      },
      onError: (error) {
        _errorMessage = 'Failed to load profile: $error';
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<bool> saveProfile(StudentProfileModel updatedProfile) async {
    try {
      await _profileService.updateProfile(updatedProfile);
      _errorMessage = null;
      return true;
    } catch (e) {
      _errorMessage = 'Failed to save profile: $e';
      notifyListeners();
      return false;
    }
  }

  /// Saves a new profile photo to the device's local storage and
  /// records its local path in the user's Firestore profile document
  /// — this is what makes the photo survive app restarts on THIS
  /// device (see LocalStorageService for the multi-device limitation).
  Future<bool> saveProfilePhoto(File photoFile) async {
    if (_currentUid == null || _profile == null) return false;
    try {
      final localPath =
          await _localStorageService.saveProfilePhoto(_currentUid!, photoFile);
      final updated = _profile!.copyWith(profileImagePath: localPath);
      await _profileService.updateProfile(updated);
      _errorMessage = null;
      return true;
    } catch (e) {
      _errorMessage = 'Failed to save photo: $e';
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