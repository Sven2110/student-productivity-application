import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../l10n/app_localizations.dart';
import '../../models/calendar_event_model.dart';
import '../../models/reminder_offset.dart';

class CalendarEventForm extends StatefulWidget {
  final CalendarEventModel? existingEvent;
  final CalendarEventCategory initialCategory;
  final DateTime initialDate;
  final int? initialHour;

  const CalendarEventForm({
    super.key,
    this.existingEvent,
    required this.initialCategory,
    required this.initialDate,
    this.initialHour,
  });

  @override
  State<CalendarEventForm> createState() => _CalendarEventFormState();
}

class _CalendarEventFormState extends State<CalendarEventForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late CalendarEventCategory _category;
  late DateTime _date;
  bool _isAllDay = false;
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;
  late ReminderOffset _reminderOffset;

  static const List<Color> _colorOptions = [
    Color(0xFF4F46E5), Color(0xFF16A34A), Color(0xFFEA580C),
    Color(0xFF0891B2), Color(0xFF9333EA), Color(0xFFDC2626),
  ];
  late Color _selectedColor;

  @override
  void initState() {
    super.initState();
    final existing = widget.existingEvent;
    _titleController = TextEditingController(text: existing?.title ?? '');
    _descriptionController = TextEditingController(text: existing?.description ?? '');
    _category = existing?.category ?? widget.initialCategory;
    _date = existing?.date ?? widget.initialDate;
    _isAllDay = existing?.isAllDay ?? false;
    final startMin = existing?.startMinutes ?? (widget.initialHour ?? 9) * 60;
    final endMin = existing?.endMinutes ?? startMin + 60;
    _startTime = TimeOfDay(hour: startMin ~/ 60, minute: startMin % 60);
    _endTime = TimeOfDay(hour: endMin ~/ 60, minute: endMin % 60);
    _reminderOffset = ReminderOffsetX.fromMinutes(existing?.reminderOffsetMinutes);
    _selectedColor = existing != null ? Color(existing.colorValue) : _colorOptions[0];
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(DateTime.now().year - 10, 1, 1),
      lastDate: DateTime(DateTime.now().year + 100, 12, 31),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _pickTime(bool isStart) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isStart ? _startTime : _endTime,
    );
    if (picked != null) {
      setState(() => isStart ? _startTime = picked : _endTime = picked);
    }
  }

  void _handleSave() {
    if (!_formKey.currentState!.validate()) return;
    final l10n = AppLocalizations.of(context)!;

    int? startMinutes;
    int? endMinutes;
    if (!_isAllDay) {
      startMinutes = _startTime.hour * 60 + _startTime.minute;
      endMinutes = _endTime.hour * 60 + _endTime.minute;
      if (endMinutes <= startMinutes) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.eventFormEndBeforeStart)),
        );
        return;
      }
    }

    final event = CalendarEventModel(
      id: widget.existingEvent?.id ?? '',
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      category: _category,
      date: _date,
      isAllDay: _isAllDay,
      startMinutes: startMinutes,
      endMinutes: endMinutes,
      colorValue: _selectedColor.value,
      reminderOffsetMinutes: _reminderOffset.minutes,
    );

    Navigator.of(context).pop(event);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final dateFormat = DateFormat.yMd(Localizations.localeOf(context).toString());

    return Padding(
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
                widget.existingEvent == null
                    ? l10n.eventFormNewTitle(_category.label(l10n))
                    : l10n.eventFormEditTitle(_category.label(l10n)),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                children: CalendarEventCategory.values.map((cat) {
                  return ChoiceChip(
                    label: Text(cat.label(l10n)),
                    avatar: Icon(cat.icon, size: 16),
                    selected: _category == cat,
                    onSelected: (_) => setState(() => _category = cat),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: l10n.eventFormTitleLabel,
                  prefixIcon: const Icon(Icons.title),
                  border: const OutlineInputBorder(),
                ),
                validator: (v) => (v == null || v.trim().isEmpty) ? l10n.required : null,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _descriptionController,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: l10n.eventFormDescriptionLabel,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 14),
              OutlinedButton.icon(
                onPressed: _pickDate,
                icon: const Icon(Icons.calendar_today_outlined),
                label: Text(dateFormat.format(_date)),
              ),
              const SizedBox(height: 10),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(l10n.eventFormAllDay),
                value: _isAllDay,
                onChanged: (v) => setState(() => _isAllDay = v),
              ),
              if (!_isAllDay) ...[
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _pickTime(true),
                        icon: const Icon(Icons.access_time),
                        label: Text(l10n.eventFormStart(_startTime.format(context))),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _pickTime(false),
                        icon: const Icon(Icons.access_time_filled),
                        label: Text(l10n.eventFormEnd(_endTime.format(context))),
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 14),
              DropdownButtonFormField<ReminderOffset>(
                initialValue: _reminderOffset,
                decoration: InputDecoration(
                  labelText: l10n.eventFormReminder,
                  prefixIcon: const Icon(Icons.notifications_outlined),
                  border: const OutlineInputBorder(),
                ),
                items: ReminderOffset.values
                    .map((o) => DropdownMenuItem(value: o, child: Text(o.label(l10n))))
                    .toList(),
                onChanged: (value) {
                  if (value != null) setState(() => _reminderOffset = value);
                },
              ),
              const SizedBox(height: 10),
              Text(l10n.eventFormColor, style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 10,
                children: _colorOptions.map((color) {
                  final isSelected = color.value == _selectedColor.value;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedColor = color),
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: color,
                      child: isSelected ? const Icon(Icons.check, color: Colors.white, size: 16) : null,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 22),
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: _handleSave,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(l10n.save),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}