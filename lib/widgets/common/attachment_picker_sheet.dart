import 'dart:io';
import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../core/services/camera_service.dart';
import '../../core/services/file_service.dart';

/// Result of picking any attachment source — a file plus its
/// suggested display name — regardless of whether it came from the
/// camera, gallery, or the general file picker.
class PickedAttachmentInput {
  final File file;
  final String fileName;

  const PickedAttachmentInput({required this.file, required this.fileName});
}

enum _AttachSource { camera, gallery, file }

/// Shows a bottom sheet offering Camera / Gallery / File, and returns
/// the picked result, or null if the user cancelled at any step.
/// This is the ONE place in the app that decides how attachments are
/// picked — every feature (Tasks, Projects, Notes) calls this exact
/// function rather than re-implementing the source-selection UI.
Future<PickedAttachmentInput?> showAttachmentPickerSheet(BuildContext context) async {
  final l10n = AppLocalizations.of(context)!;

  final source = await showModalBottomSheet<_AttachSource>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (ctx) => SafeArea(
      child: Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt_outlined),
            title: Text(l10n.attachTakePhoto),
            onTap: () => Navigator.pop(ctx, _AttachSource.camera),
          ),
          ListTile(
            leading: const Icon(Icons.photo_library_outlined),
            title: Text(l10n.attachChooseGallery),
            onTap: () => Navigator.pop(ctx, _AttachSource.gallery),
          ),
          ListTile(
            leading: const Icon(Icons.insert_drive_file_outlined),
            title: Text(l10n.attachChooseFile),
            onTap: () => Navigator.pop(ctx, _AttachSource.file),
          ),
        ],
      ),
    ),
  );

  if (source == null) return null;

  switch (source) {
    case _AttachSource.camera:
      final file = await CameraService().captureFromCamera();
      if (file == null) return null;
      return PickedAttachmentInput(file: file, fileName: file.path.split('/').last);

    case _AttachSource.gallery:
      final file = await CameraService().pickFromGallery();
      if (file == null) return null;
      return PickedAttachmentInput(file: file, fileName: file.path.split('/').last);

    case _AttachSource.file:
      final result = await FileService().pickFile();
      if (result == null) return null;
      return PickedAttachmentInput(file: result.file, fileName: result.fileName);
  }
}