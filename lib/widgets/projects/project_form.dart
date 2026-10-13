import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../models/project_model.dart';
import '../../models/attachment_model.dart';
import '../../providers/project_provider.dart';
import '../../core/services/attachment_service.dart';
import '../../widgets/common/attachment_section.dart';
import '../../widgets/common/attachment_picker_sheet.dart';

/// Bottom-sheet form for creating / editing a project.
///
/// SAVING HAPPENS INSIDE THIS FORM (same pattern as the Notes editor):
/// on "Save" the form copies the picked files (camera, gallery or
/// file picker) into permanent storage, writes the project +
/// attachments to Firestore in one write, and only closes once that
/// succeeded. On failure the sheet stays open with the user's input
/// and the real error is shown.
///
/// On success the sheet pops with the saved [ProjectModel] (already
/// persisted — the caller must NOT save it again; it is returned only
/// so the screen can switch to the matching status tab).
class ProjectForm extends StatefulWidget {
  final ProjectModel? existingProject;
  final ProjectStatus initialStatus;

  const ProjectForm({
    super.key,
    this.existingProject,
    this.initialStatus = ProjectStatus.pending,
  });

  @override
  State<ProjectForm> createState() => _ProjectFormState();
}

class _ProjectFormState extends State<ProjectForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late ProjectStatus _status;
  DateTime? _dueDate;
  bool _isSaving = false;

  final _attachmentService = AttachmentService();
  late List<AttachmentModel> _existingAttachments;
  final List<PickedAttachmentInput> _pendingAttachments = [];

  @override
  void initState() {
    super.initState();
    final existing = widget.existingProject;
    _titleController = TextEditingController(text: existing?.title ?? '');
    _descriptionController = TextEditingController(text: existing?.description ?? '');
    _status = existing?.status ?? widget.initialStatus;
    _dueDate = existing?.dueDate;
    _existingAttachments = List<AttachmentModel>.from(existing?.attachments ?? const []);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDueDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    );
    if (picked != null) setState(() => _dueDate = picked);
  }

  Future<void> _handleRemoveExisting(AttachmentModel attachment) async {
    final provider = context.read<ProjectProvider>();
    final updated = await _attachmentService.removeAttachment(
      currentAttachments: _existingAttachments,
      attachment: attachment,
    );
    if (mounted) setState(() => _existingAttachments = updated);

    if (widget.existingProject != null) {
      await provider.persistAttachments(widget.existingProject!.id, updated);
    }
  }

  Future<void> _handleSave() async {
    if (_isSaving) return;
    if (!_formKey.currentState!.validate()) return;
    final l10n = AppLocalizations.of(context)!;

    // Grab everything we need from `context` BEFORE any await, so the
    // save can finish correctly even if the sheet is dismissed midway.
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final provider = context.read<ProjectProvider>();

    setState(() => _isSaving = true);

    final projectId = widget.existingProject?.id ?? provider.generateProjectId();
    if (projectId == null) {
      if (mounted) setState(() => _isSaving = false);
      messenger.showSnackBar(SnackBar(content: Text(l10n.somethingWentWrong)));
      return;
    }

    // 1) Copy every picked file (camera / gallery / file picker) into
    //    the app's permanent storage under attachments/projects/{id}/.
    var attachments = List<AttachmentModel>.from(_existingAttachments);
    final newlySaved = <AttachmentModel>[];
    final failedNames = <String>[];
    for (final pending in _pendingAttachments) {
      try {
        final updated = await _attachmentService.addAttachment(
          feature: 'projects',
          itemId: projectId,
          currentAttachments: attachments,
          file: pending.file,
          fileName: pending.fileName,
        );
        newlySaved.add(updated.last);
        attachments = updated;
      } catch (_) {
        failedNames.add(pending.fileName);
      }
    }

    // 2) Save the project together with its attachment list (one write).
    final project = ProjectModel(
      id: projectId,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      status: _status,
      dueDate: _dueDate,
      createdAt: widget.existingProject?.createdAt ?? DateTime.now(),
      attachments: attachments,
    );

    final saved = await provider.saveProject(project);

    if (!saved) {
      // Nothing was saved — remove the files we just copied so they
      // don't pile up as orphans, and keep the form open.
      for (final a in newlySaved) {
        await _attachmentService.removeAttachment(
          currentAttachments: attachments,
          attachment: a,
        );
      }
      if (mounted) setState(() => _isSaving = false);
      messenger.showSnackBar(
        SnackBar(content: Text(provider.errorMessage ?? l10n.somethingWentWrong)),
      );
      return;
    }

    // 3) Success — report partial problems, then close.
    if (failedNames.isNotEmpty) {
      messenger.showSnackBar(SnackBar(
        content: Text('Project saved, but these files could not be attached: ${failedNames.join(', ')}'),
      ));
    }

    if (mounted) navigator.pop(project);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final dateFormat = DateFormat.yMd(Localizations.localeOf(context).toString());

    return PopScope(
      canPop: !_isSaving,
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  widget.existingProject == null ? l10n.projectFormNewTitle : l10n.projectFormEditTitle,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: l10n.projectFormTitleLabel,
                    prefixIcon: const Icon(Icons.folder_outlined),
                    border: const OutlineInputBorder(),
                  ),
                  validator: (v) => (v == null || v.trim().isEmpty) ? l10n.required : null,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: l10n.projectFormDescriptionLabel,
                    alignLabelWithHint: true,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 14),
                OutlinedButton.icon(
                  onPressed: _pickDueDate,
                  icon: const Icon(Icons.calendar_today_outlined),
                  label: Text(
                    _dueDate == null
                        ? l10n.projectFormSetDueDate
                        : l10n.projectFormDuePrefix(dateFormat.format(_dueDate!)),
                  ),
                ),
                const SizedBox(height: 16),
                Text(l10n.projectFormStatus, style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: ProjectStatus.values.map((status) {
                    final selected = _status == status;
                    return ChoiceChip(
                      label: Text(status.label(l10n)),
                      selected: selected,
                      onSelected: (_) => setState(() => _status = status),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                AttachmentSection(
                  existingAttachments: _existingAttachments,
                  pendingAttachments: _pendingAttachments,
                  onPicked: (picked) => setState(() => _pendingAttachments.add(picked)),
                  onRemoveExisting: _handleRemoveExisting,
                  onRemovePending: (index) => setState(() => _pendingAttachments.removeAt(index)),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _isSaving ? null : _handleSave,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: _isSaving
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(l10n.save),
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