import 'dart:io';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import '../../l10n/app_localizations.dart';
import '../../models/attachment_model.dart';
import 'attachment_picker_sheet.dart';

/// Reusable "Attachments" block: header + Add button, then a wrap of
/// chips for both already-saved attachments (openable, deletable)
/// and pending ones picked this session but not yet persisted
/// (deletable, shown in a different color so it's clear they're not
/// saved yet). Used identically by Task, Project, and Note forms.
class AttachmentSection extends StatelessWidget {
  final List<AttachmentModel> existingAttachments;
  final List<PickedAttachmentInput> pendingAttachments;
  final void Function(PickedAttachmentInput picked) onPicked;
  final void Function(AttachmentModel attachment) onRemoveExisting;
  final void Function(int index) onRemovePending;

  const AttachmentSection({
    super.key,
    required this.existingAttachments,
    required this.pendingAttachments,
    required this.onPicked,
    required this.onRemoveExisting,
    required this.onRemovePending,
  });

  Future<void> _handleOpen(BuildContext context, AttachmentModel attachment) async {
    final l10n = AppLocalizations.of(context)!;
    final result = await OpenFilex.open(attachment.localPath);
    if (result.type != ResultType.done && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.attachmentsOpenFailed(result.message))),
      );
    }
  }

  Widget _thumbnail(String? localPath, bool isImage) {
    if (isImage && localPath != null && File(localPath).existsSync()) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Image.file(File(localPath), width: 32, height: 32, fit: BoxFit.cover),
      );
    }
    return const Icon(Icons.insert_drive_file_outlined, size: 20);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(l10n.attachmentsTitle, style: const TextStyle(fontWeight: FontWeight.w600)),
            TextButton.icon(
              onPressed: () async {
                final picked = await showAttachmentPickerSheet(context);
                if (picked != null) onPicked(picked);
              },
              icon: const Icon(Icons.add, size: 18),
              label: Text(l10n.attachmentsAdd),
            ),
          ],
        ),
        if (existingAttachments.isEmpty && pendingAttachments.isEmpty)
          Text(l10n.attachmentsNone, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ...existingAttachments.map((attachment) => InkWell(
                  onTap: () => _handleOpen(context, attachment),
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF16A34A).withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _thumbnail(attachment.localPath, attachment.isImage),
                        const SizedBox(width: 6),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 100),
                          child: Text(
                            attachment.fileName,
                            style: const TextStyle(fontSize: 12, color: Color(0xFF16A34A)),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () => onRemoveExisting(attachment),
                          child: const Icon(Icons.close, size: 14, color: Color(0xFF16A34A)),
                        ),
                      ],
                    ),
                  ),
                )),
            ...pendingAttachments.asMap().entries.map((entry) {
              final index = entry.key;
              final picked = entry.value;
              final isImage = ['jpg', 'jpeg', 'png', 'gif', 'webp']
                  .contains(picked.fileName.toLowerCase().split('.').last);
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF0891B2).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _thumbnail(picked.file.path, isImage),
                    const SizedBox(width: 6),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 100),
                      child: Text(
                        l10n.attachmentsPendingSuffix(picked.fileName),
                        style: const TextStyle(fontSize: 12, color: Color(0xFF0891B2)),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () => onRemovePending(index),
                      child: const Icon(Icons.close, size: 14, color: Color(0xFF0891B2)),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ],
    );
  }
}