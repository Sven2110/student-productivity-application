import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/profile_provider.dart';
import '../../models/student_profile_model.dart';
import '../../core/services/camera_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cameraService = CameraService();

  late TextEditingController _nameController;
  late TextEditingController _studentIdController;
  late TextEditingController _courseController;
  int _yearOfStudy = 1;
  bool _initialized = false;
  bool _isSaving = false;

  File? _localPhotoPreview;
  bool _isSavingPhoto = false;

  @override
  void dispose() {
    if (_initialized) {
      _nameController.dispose();
      _studentIdController.dispose();
      _courseController.dispose();
    }
    super.dispose();
  }

  void _initControllersIfNeeded(StudentProfileModel profile) {
    if (_initialized) return;
    _nameController = TextEditingController(text: profile.fullName);
    _studentIdController = TextEditingController(text: profile.studentId);
    _courseController = TextEditingController(text: profile.course);
    _yearOfStudy = profile.yearOfStudy;
    _initialized = true;
  }

  Future<void> _showPhotoSourceSheet() async {
    final l10n = AppLocalizations.of(context)!;
    final source = await showModalBottomSheet<_PhotoSource>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: Text(l10n.profileTakePhoto),
              onTap: () => Navigator.pop(ctx, _PhotoSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: Text(l10n.profileChooseGallery),
              onTap: () => Navigator.pop(ctx, _PhotoSource.gallery),
            ),
          ],
        ),
      ),
    );

    if (source == null) return;

    final photo = source == _PhotoSource.camera
        ? await _cameraService.captureFromCamera()
        : await _cameraService.pickFromGallery();

    if (photo == null || !mounted) return;

    setState(() {
      _localPhotoPreview = photo;
      _isSavingPhoto = true;
    });

    final profileProvider = context.read<ProfileProvider>();
    final success = await profileProvider.saveProfilePhoto(photo);

    if (!mounted) return;
    setState(() {
      _isSavingPhoto = false;
      if (success) _localPhotoPreview = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(success ? l10n.profilePhotoSaved : l10n.profilePhotoFailed),
      ),
    );
  }

  Future<void> _handleSave(StudentProfileModel currentProfile) async {
    if (!_formKey.currentState!.validate()) return;
    final l10n = AppLocalizations.of(context)!;

    setState(() => _isSaving = true);

    final updated = currentProfile.copyWith(
      fullName: _nameController.text.trim(),
      studentId: _studentIdController.text.trim(),
      course: _courseController.text.trim(),
      yearOfStudy: _yearOfStudy,
    );

    final profileProvider = context.read<ProfileProvider>();
    final success = await profileProvider.saveProfile(updated);

    if (!mounted) return;
    setState(() => _isSaving = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(success ? l10n.profileUpdated : l10n.profileUpdateFailed),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.watch<ProfileProvider>();
    final profile = profileProvider.profile;
    final l10n = AppLocalizations.of(context)!;

    if (profileProvider.isLoading || profile == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.profileTitle)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    _initControllersIfNeeded(profile);

    final hasLocalPreview = _localPhotoPreview != null;
    // Check the file actually still exists on disk before trying to
    // render it — protects against a stale path if app data was
    // ever partially cleared.
    final hasSavedPhoto = profile.profileImagePath != null &&
        profile.profileImagePath!.isNotEmpty &&
        File(profile.profileImagePath!).existsSync();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.profileTitle)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: const Color(0xFF4F46E5),
                        backgroundImage: hasLocalPreview
                            ? FileImage(_localPhotoPreview!) as ImageProvider
                            : hasSavedPhoto
                                ? FileImage(File(profile.profileImagePath!))
                                : null,
                        child: (!hasLocalPreview && !hasSavedPhoto)
                            ? Text(
                                profile.email.isNotEmpty ? profile.email[0].toUpperCase() : '?',
                                style: const TextStyle(fontSize: 36, color: Colors.white),
                              )
                            : null,
                      ),
                      if (_isSavingPhoto)
                        Positioned.fill(
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.black.withValues(alpha: 0.4),
                            child: const CircularProgressIndicator(color: Colors.white),
                          ),
                        ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _isSavingPhoto ? null : _showPhotoSourceSheet,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF4F46E5),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(profile.email, style: const TextStyle(color: Colors.grey)),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: l10n.profileFullName,
                    prefixIcon: const Icon(Icons.person_outline),
                    border: const OutlineInputBorder(),
                  ),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? l10n.profileFullNameRequired : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _studentIdController,
                  decoration: InputDecoration(
                    labelText: l10n.profileStudentId,
                    prefixIcon: const Icon(Icons.badge_outlined),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _courseController,
                  decoration: InputDecoration(
                    labelText: l10n.profileCourseMajor,
                    prefixIcon: const Icon(Icons.school_outlined),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<int>(
                  initialValue: _yearOfStudy,
                  decoration: InputDecoration(
                    labelText: l10n.profileYearOfStudy,
                    prefixIcon: const Icon(Icons.calendar_today_outlined),
                    border: const OutlineInputBorder(),
                  ),
                  items: [1, 2, 3, 4, 5]
                      .map((y) => DropdownMenuItem(value: y, child: Text(l10n.profileYearN(y))))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) setState(() => _yearOfStudy = value);
                  },
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isSaving ? null : () => _handleSave(profile),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isSaving
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.white,
                            ),
                          )
                        : Text(l10n.profileSaveChanges, style: const TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum _PhotoSource { camera, gallery }