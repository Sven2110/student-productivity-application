import 'dart:io';
import 'package:path_provider/path_provider.dart';

/// Handles saving picked/captured files permanently to the app's
/// own private local storage directory on the device.
///
/// LIMITATION (deliberate, by design choice — see Phase 15): files
/// saved here exist ONLY on this device.
class LocalStorageService {
  /// Fixed path per user (profile_photos/{uid}.jpg) — re-saving
  /// overwrites the previous photo instead of accumulating old ones.
  /// Kept as its own method since profile photo is a special "always
  /// exactly one, always overwritten" case, unlike generic attachments.
  Future<String> saveProfilePhoto(String uid, File sourceFile) async {
    final appDir = await getApplicationDocumentsDirectory();
    final targetDir = Directory('${appDir.path}/profile_photos');
    if (!await targetDir.exists()) {
      await targetDir.create(recursive: true);
    }

    final targetPath = '${targetDir.path}/$uid.jpg';
    final savedFile = await sourceFile.copy(targetPath);
    return savedFile.path;
  }

  /// Generic attachment save, used by Tasks, Projects, Notes, and any
  /// future feature. Files are scoped under
  /// attachments/{feature}/{itemId}/ so different items' attachments
  /// never collide, and a unique timestamp prefix on the filename
  /// prevents collisions when a user attaches two files with the
  /// same original name (e.g. two photos both named "IMG_001.jpg").
  Future<String> saveAttachment(
    String feature,
    String itemId,
    File sourceFile,
    String fileName,
  ) async {
    final appDir = await getApplicationDocumentsDirectory();
    final targetDir = Directory('${appDir.path}/attachments/$feature/$itemId');
    if (!await targetDir.exists()) {
      await targetDir.create(recursive: true);
    }

    final uniquePrefix = DateTime.now().microsecondsSinceEpoch;
    final targetPath = '${targetDir.path}/${uniquePrefix}_$fileName';
    final savedFile = await sourceFile.copy(targetPath);
    return savedFile.path;
  }

  /// Best-effort delete — silently ignored on failure.
  Future<void> deleteLocalFile(String path) async {
    try {
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (_) {
      // Best-effort cleanup only.
    }
  }
}