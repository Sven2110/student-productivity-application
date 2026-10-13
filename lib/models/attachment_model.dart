/// Represents file and photo attachment metadata that can be reused 
/// across Tasks, Projects, Notes, and future features. Attachments 
/// are stored as an array directly in the parent document (e.g. /// task.attachments) instead of a separate Firestore collection. 
/// Since each attachment only stores basic metadata, such as the 
/// local file path, name, and size, multiple attachments can be 
/// stored per item without approaching Firestore's document size limit.
class AttachmentModel {
  final String id;
  final String fileName;
  /// Absolute local file path on this device (see LocalStorageService
  /// for why attachments are device-local, established in Phase 15).
  final String localPath;
  final int sizeBytes;
  final DateTime addedAt;

  const AttachmentModel({
    required this.id,
    required this.fileName,
    required this.localPath,
    required this.sizeBytes,
    required this.addedAt,
  });

  bool get isImage {
    final ext = fileName.toLowerCase().split('.').last;
    return ['jpg', 'jpeg', 'png', 'gif', 'webp', 'bmp'].contains(ext);
  }

  String get readableSize {
    if (sizeBytes < 1024) return '$sizeBytes B';
    if (sizeBytes < 1024 * 1024) return '${(sizeBytes / 1024).toStringAsFixed(1)} KB';
    return '${(sizeBytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  factory AttachmentModel.fromMap(Map<String, dynamic> map) {
    return AttachmentModel(
      id: map['id'] as String? ?? '',
      fileName: map['fileName'] as String? ?? '',
      localPath: map['localPath'] as String? ?? '',
      sizeBytes: map['sizeBytes'] as int? ?? 0,
      addedAt: DateTime.fromMillisecondsSinceEpoch(map['addedAt'] as int? ?? 0),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fileName': fileName,
      'localPath': localPath,
      'sizeBytes': sizeBytes,
      'addedAt': addedAt.millisecondsSinceEpoch,
    };
  }
}