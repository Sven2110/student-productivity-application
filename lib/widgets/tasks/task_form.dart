import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../models/task_model.dart';
import '../../models/attachment_model.dart';
import '../../models/reminder_offset.dart';
import '../../providers/task_provider.dart';
import '../../core/services/attachment_service.dart';
import '../../widgets/common/attachment_section.dart';
import '../../widgets/common/attachment_picker_sheet.dart';

/// Bottom-sheet form for creating / editing a task.
///
/// SAVING HAPPENS INSIDE THIS FORM (same pattern as the Notes editor,
/// which is the part of the app that already worked): on "Save" the
/// form copies the picked files into permanent storage, then writes
/// the task + attachments to Firestore in one write, and only closes
/// itself once that has succeeded. If saving fails, the sheet stays
/// open with everything the user entered, and the real error is shown.
///
/// The sheet pops with no value; callers do not need to save anything.
class TaskForm extends StatefulWidget {
  final TaskModel? existingTask;

  /// Pre-fills the due date for NEW tasks (e.g. the day currently
  /// selected in the Calendar), so a task created there actually
  /// shows up on that day instead of having no date.
  final DateTime? initialDueDate;

  const TaskForm({super.key, this.existingTask, this.initialDueDate});

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  DateTime? _dueDate;
  TimeOfDay? _dueTime;
  late TaskPriority _priority;
  late ReminderOffset _reminderOffset;
  bool _isSaving = false;

  final _attachmentService = AttachmentService();
  late List<AttachmentModel> _existingAttachments;
  final List<PickedAttachmentInput> _pendingAttachments = [];

  @override
  void initState() {
    super.initState();
    final existing = widget.existingTask;
    _titleController = TextEditingController(text: existing?.title ?? '');
    _descriptionController = TextEditingController(text: existing?.description ?? '');
    _dueDate = existing != null
        ? existing.dueDate
        : (widget.initialDueDate == null
            ? null
            : DateTime(widget.initialDueDate!.year, widget.initialDueDate!.month,
                widget.initialDueDate!.day));
    _dueTime = existing?.dueTimeMinutes != null
        ? TimeOfDay(hour: existing!.dueTimeMinutes! ~/ 60, minute: existing.dueTimeMinutes! % 60)
        : null;
    _priority = existing?.priority ?? TaskPriority.medium;
    _reminderOffset = ReminderOffsetX.fromMinutes(existing?.reminderOffsetMinutes);
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
      firstDate: DateTime(DateTime.now().year - 10, 1, 1),
      lastDate: DateTime(DateTime.now().year + 100, 12, 31),
    );
    if (picked != null) setState(() => _dueDate = picked);
  }

  Future<void> _pickDueTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _dueTime ?? const TimeOfDay(hour: 9, minute: 0),
    );
    if (picked != null) setState(() => _dueTime = picked);
  }

  Future<void> _handleRemoveExisting(AttachmentModel attachment) async {
    final provider = context.read<TaskProvider>();
    final updated = await _attachmentService.removeAttachment(
      currentAttachments: _existingAttachments,
      attachment: attachment,
    );
    if (mounted) setState(() => _existingAttachments = updated);

    if (widget.existingTask != null) {
      await provider.persistAttachments(widget.existingTask!.id, updated);
    }
  }

  Future<void> _handleSave() async {
    if (_isSaving) return;
    if (!_formKey.currentState!.validate()) return;
    final l10n = AppLocalizations.of(context)!;

    if (_reminderOffset != ReminderOffset.none && _dueDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.taskFormReminderRequiresDueDate)),
      );
      return;
    }

    // Grab everything we need from `context` BEFORE any await, so the
    // save can finish correctly even if the sheet is dismissed midway.
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final provider = context.read<TaskProvider>();

    setState(() => _isSaving = true);

    final taskId = widget.existingTask?.id ?? provider.generateTaskId();
    if (taskId == null) {
      if (mounted) setState(() => _isSaving = false);
      messenger.showSnackBar(SnackBar(content: Text(l10n.somethingWentWrong)));
      return;
    }

    // 1) Copy every picked file (camera / gallery / file picker) into
    //    the app's permanent storage under attachments/tasks/{taskId}/.
    var attachments = List<AttachmentModel>.from(_existingAttachments);
    final newlySaved = <AttachmentModel>[];
    final failedNames = <String>[];
    for (final pending in _pendingAttachments) {
      try {
        final updated = await _attachmentService.addAttachment(
          feature: 'tasks',
          itemId: taskId,
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

    // 2) Save the task together with its attachment list (one write).
    final task = TaskModel(
      id: taskId,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      dueDate: _dueDate,
      dueTimeMinutes: _dueTime != null ? _dueTime!.hour * 60 + _dueTime!.minute : null,
      priority: _priority,
      isCompleted: widget.existingTask?.isCompleted ?? false,
      createdAt: widget.existingTask?.createdAt ?? DateTime.now(),
      attachments: attachments,
      reminderOffsetMinutes: _reminderOffset.minutes,
    );

    final saved = await provider.saveTask(task);

    if (!saved) {
      // Nothing was saved — remove the files we just copied so they
      // don't pile up as orphans, and keep the form open so the user
      // loses nothing.
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

    // 3) Success — report any partial problems, then close.
    if (failedNames.isNotEmpty) {
      messenger.showSnackBar(SnackBar(
        content: Text('Task saved, but these files could not be attached: ${failedNames.join(', ')}'),
      ));
    } else if (provider.warningMessage != null) {
      messenger.showSnackBar(SnackBar(content: Text(provider.warningMessage!)));
    }

    if (mounted) navigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final dateFormat = DateFormat.yMd(Localizations.localeOf(context).toString());

    return PopScope(
      canPop: !_isSaving,
      child: Padding(
        padding: EdgeInsets.only(
          left: 20, right: 20, top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  widget.existingTask == null ? l10n.taskFormNewTitle : l10n.taskFormEditTitle,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: l10n.taskFormTitleLabel,
                    prefixIcon: const Icon(Icons.title),
                    border: const OutlineInputBorder(),
                  ),
                  validator: (v) => (v == null || v.trim().isEmpty) ? l10n.required : null,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: l10n.taskFormDescriptionLabel,
                    alignLabelWithHint: true,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _pickDueDate,
                        icon: const Icon(Icons.calendar_today_outlined),
                        label: Text(
                          _dueDate == null ? l10n.taskFormDueDatePlaceholder : dateFormat.format(_dueDate!),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _dueDate == null ? null : _pickDueTime,
                        icon: const Icon(Icons.access_time),
                        label: Text(_dueTime == null ? l10n.taskFormDueTimePlaceholder : _dueTime!.format(context)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(l10n.taskFormPriority, style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                SegmentedButton<TaskPriority>(
                  segments: [
                    ButtonSegment(value: TaskPriority.low, label: Text(l10n.priorityLow)),
                    ButtonSegment(value: TaskPriority.medium, label: Text(l10n.priorityMedium)),
                    ButtonSegment(value: TaskPriority.high, label: Text(l10n.priorityHigh)),
                  ],
                  selected: {_priority},
                  onSelectionChanged: (selection) {
                    setState(() => _priority = selection.first);
                  },
                ),
                const SizedBox(height: 14),
                DropdownButtonFormField<ReminderOffset>(
                  initialValue: _reminderOffset,
                  decoration: InputDecoration(
                    labelText: l10n.eventFormReminder,
                    prefixIcon: const Icon(Icons.notifications_outlined),
                    border: const OutlineInputBorder(),
                    helperText: l10n.reminderRequiresDueDateHelper,
                  ),
                  items: ReminderOffset.values
                      .map((o) => DropdownMenuItem(value: o, child: Text(o.label(l10n))))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) setState(() => _reminderOffset = value);
                  },
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