import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/note_provider.dart';
import '../../providers/timetable_provider.dart';
import '../../models/note_model.dart';
import '../../models/attachment_model.dart';
import '../../core/services/attachment_service.dart';
import '../../widgets/common/attachment_section.dart';
import '../../widgets/common/attachment_picker_sheet.dart';

class NoteEditorScreen extends StatefulWidget {
  final NoteModel? existingNote;

  const NoteEditorScreen({super.key, this.existingNote});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  String? _selectedSubject;
  bool _useCustomSubject = false;
  late TextEditingController _customSubjectController;
  bool _isSaving = false;

  final _attachmentService = AttachmentService();
  late List<AttachmentModel> _existingAttachments;
  final List<PickedAttachmentInput> _pendingAttachments = [];

  @override
  void initState() {
    super.initState();
    final existing = widget.existingNote;
    _titleController = TextEditingController(text: existing?.title ?? '');
    _contentController = TextEditingController(text: existing?.content ?? '');
    _customSubjectController = TextEditingController();
    _selectedSubject = existing?.subject;
    _existingAttachments = existing?.attachments ?? [];
    if (existing != null && existing.subject.isNotEmpty) {
      _customSubjectController.text = existing.subject;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _customSubjectController.dispose();
    super.dispose();
  }

  List<String> _allSubjects() {
    final timetableSubjects =
        context.read<TimetableProvider>().entries.map((e) => e.subject).toSet();
    final noteSubjects = context.read<NoteProvider>().subjectsWithNotes.toSet();
    final combined = {...timetableSubjects, ...noteSubjects}.toList();
    combined.sort();
    return combined;
  }

  /// If the note already exists (has an ID), removing an attachment
  /// deletes the file and persists immediately. If it's a brand-new
  /// note being created, there's nothing to persist yet — the item
  /// just isn't added to _existingAttachments in the first place
  /// (new notes always start with an empty existing list).
  Future<void> _handleRemoveExisting(AttachmentModel attachment) async {
    final updated = await _attachmentService.removeAttachment(
      currentAttachments: _existingAttachments,
      attachment: attachment,
    );
    setState(() => _existingAttachments = updated);

    if (widget.existingNote != null) {
      await context.read<NoteProvider>().persistAttachments(widget.existingNote!.id, updated);
    }
  }

  Future<void> _handleSave() async {
    final l10n = AppLocalizations.of(context)!;
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.noteEnterTitleError)),
      );
      return;
    }

    final subject = _useCustomSubject
        ? _customSubjectController.text.trim()
        : (_selectedSubject ?? '');

    setState(() => _isSaving = true);

    final now = DateTime.now();
    final note = NoteModel(
      id: widget.existingNote?.id ?? '',
      title: title,
      content: _contentController.text.trim(),
      subject: subject,
      createdAt: widget.existingNote?.createdAt ?? now,
      updatedAt: now,
      attachments: _existingAttachments,
    );

    final provider = context.read<NoteProvider>();
    String? noteId = widget.existingNote?.id;
    bool success;

    if (noteId == null) {
      final newId = await provider.addNote(note);
      success = newId != null;
      noteId = newId;
    } else {
      success = await provider.updateNote(note);
    }

    // Upload any newly picked (pending) attachments now that we have
    // a definite note ID to scope their storage path under.
    if (success && noteId != null && _pendingAttachments.isNotEmpty) {
      var currentList = _existingAttachments;
      for (final pending in _pendingAttachments) {
        currentList = await _attachmentService.addAttachment(
          feature: 'notes',
          itemId: noteId,
          currentAttachments: currentList,
          file: pending.file,
          fileName: pending.fileName,
        );
      }
      success = await provider.persistAttachments(noteId, currentList);
    }

    if (!mounted) return;
    setState(() => _isSaving = false);

    if (success) {
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(provider.errorMessage ?? l10n.noteSaveFailed)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final subjects = _allSubjects();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existingNote == null ? l10n.noteEditorNewTitle : l10n.noteEditorEditTitle),
        actions: [
          IconButton(
            icon: _isSaving
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.check),
            onPressed: _isSaving ? null : _handleSave,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              decoration: InputDecoration(hintText: l10n.noteTitleHint, border: InputBorder.none),
            ),
            const Divider(),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.book_outlined, size: 18, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: subjects.isEmpty || _useCustomSubject
                      ? TextField(
                          controller: _customSubjectController,
                          decoration: InputDecoration(
                            hintText: l10n.noteSubjectHint,
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        )
                      : DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: subjects.contains(_selectedSubject) ? _selectedSubject : null,
                            hint: Text(l10n.noteSubjectHint),
                            items: [
                              ...subjects.map((s) => DropdownMenuItem(value: s, child: Text(s))),
                              DropdownMenuItem(value: '__other__', child: Text(l10n.noteSubjectOther)),
                            ],
                            onChanged: (value) {
                              setState(() {
                                if (value == '__other__') {
                                  _useCustomSubject = true;
                                } else {
                                  _selectedSubject = value;
                                }
                              });
                            },
                          ),
                        ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            AttachmentSection(
              existingAttachments: _existingAttachments,
              pendingAttachments: _pendingAttachments,
              onPicked: (picked) => setState(() => _pendingAttachments.add(picked)),
              onRemoveExisting: _handleRemoveExisting,
              onRemovePending: (index) => setState(() => _pendingAttachments.removeAt(index)),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: TextField(
                controller: _contentController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                style: const TextStyle(fontSize: 15, height: 1.5),
                decoration: InputDecoration(
                  hintText: l10n.noteContentHint,
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}