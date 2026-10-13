import 'dart:io';
import 'package:file_picker/file_picker.dart';

/// Wraps selection of arbitrary files (PDFs, docs, etc.) from device
/// storage — distinct from CameraService, which is scoped to images
/// only. This is the ONLY file that should import 'package:file_picker'
/// directly.
class FileService {
  /// Opens the system file picker and returns the selected file,
  /// or null if the user cancelled. Returns both the File itself
  /// and its display name (file_picker's path doesn't always
  /// preserve a clean readable filename on every platform, so we
  /// capture it explicitly here at selection time).
  Future<PickedFileResult?> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'txt', 'ppt', 'pptx', 'xls', 'xlsx'],
    );

    if (result == null || result.files.single.path == null) return null;

    final platformFile = result.files.single;
    return PickedFileResult(
      file: File(platformFile.path!),
      fileName: platformFile.name,
      sizeInBytes: platformFile.size,
    );
  }
}

/// Small wrapper so callers get a clean File + display name + size
/// together, rather than juggling file_picker's PlatformFile type
/// directly throughout the UI layer.
class PickedFileResult {
  final File file;
  final String fileName;
  final int sizeInBytes;

  const PickedFileResult({
    required this.file,
    required this.fileName,
    required this.sizeInBytes,
  });

  String get readableSize {
    if (sizeInBytes < 1024) return '$sizeInBytes B';
    if (sizeInBytes < 1024 * 1024) return '${(sizeInBytes / 1024).toStringAsFixed(1)} KB';
    return '${(sizeInBytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}