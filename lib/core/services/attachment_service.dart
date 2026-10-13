import 'dart:io';
import '../../models/attachment_model.dart';
import 'local_storage_service.dart';

/// Reusable orchestration layer sitting on top of LocalStorageService.
/// Every feature (Tasks, Projects, Notes) calls THIS service the same
/// way — it handles saving the file to disk, building the
/// AttachmentModel, and returning the updated list, so each feature's
/// provider only needs a thin "persist this list to Firestore" method.
class AttachmentService {
  final LocalStorageService _localStorageService = LocalStorageService();

  /// Saves [file] under the given feature/item scope and returns a
  /// NEW list with the attachment appended — does not mutate
  /// [currentAttachments].
  Future<List<AttachmentModel>> addAttachment({
    required String feature,
    required String itemId,
    required List<AttachmentModel> currentAttachments,
    required File file,
    required String fileName,
  }) async {
    final localPath =
        await _localStorageService.saveAttachment(feature, itemId, file, fileName);
    final sizeBytes = await file.length();

    final newAttachment = AttachmentModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      fileName: fileName,
      localPath: localPath,
      sizeBytes: sizeBytes,
      addedAt: DateTime.now(),
    );

    return [...currentAttachments, newAttachment];
  }

  /// Deletes the underlying file and returns a NEW list with that
  /// attachment removed — does not mutate [currentAttachments].
  Future<List<AttachmentModel>> removeAttachment({
    required List<AttachmentModel> currentAttachments,
    required AttachmentModel attachment,
  }) async {
    await _localStorageService.deleteLocalFile(attachment.localPath);
    return currentAttachments.where((a) => a.id != attachment.id).toList();
  }
}