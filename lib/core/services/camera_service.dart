import 'dart:io';
import 'package:image_picker/image_picker.dart';

/// Wraps direct interaction with the device camera AND photo gallery
/// via image_picker — kept as one service since both share the same
/// underlying plugin and the same "pick an image, return a File"
/// shape, just with a different ImageSource.
class CameraService {
  final ImagePicker _picker = ImagePicker();

  /// Opens the device camera and returns the captured photo as a
  /// File, or null if the user cancelled.
  Future<File?> captureFromCamera() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 70,
      maxWidth: 1024,
    );
    if (photo == null) return null;
    return File(photo.path);
  }

  /// Opens the device's photo gallery/picker and returns the chosen
  /// image as a File, or null if the user cancelled without picking
  /// anything. Same quality/size constraints as the camera capture,
  /// for consistency between the two photo sources.
  Future<File?> pickFromGallery() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
      maxWidth: 1024,
    );
    if (photo == null) return null;
    return File(photo.path);
  }
}