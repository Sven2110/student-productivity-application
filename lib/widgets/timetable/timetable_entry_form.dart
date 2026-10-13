import 'package:flutter/material.dart';
import '../../models/timetable_entry_model.dart';

/// Bottom sheet form for creating or editing a timetable entry.
/// Returns the constructed TimetableEntryModel via Navigator.pop,
/// or null if the user cancels — the caller decides whether to
/// call addEntry or updateEntry based on whether an id was passed in.
class TimetableEntryForm extends StatefulWidget {
  final TimetableEntryModel? existingEntry;
  final int initialDay;

  const TimetableEntryForm({
    super.key,
    this.existingEntry,
    required this.initialDay,
  });

  @override
  State<TimetableEntryForm> createState() => _TimetableEntryFormState();
}

class _TimetableEntryFormState extends State<TimetableEntryForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _subjectController;
  late TextEditingController _locationController;
  late int _dayOfWeek;
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;
  late Color _selectedColor;

  static const List<Color> _colorOptions = [
    Color(0xFF4F46E5),
    Color(0xFF16A34A),
    Color(0xFFEA580C),
    Color(0xFF0891B2),
    Color(0xFF9333EA),
    Color(0xFFD97706),
    Color(0xFFDC2626),
  ];

  @override
  void initState() {
    super.initState();
    final existing = widget.existingEntry;
    _subjectController = TextEditingController(text: existing?.subject ?? '');
    _locationController = TextEditingController(text: existing?.location ?? '');
    _dayOfWeek = existing?.dayOfWeek ?? widget.initialDay;
    _startTime = existing != null
        ? TimeOfDay(hour: existing.startMinutes ~/ 60, minute: existing.startMinutes % 60)
        : const TimeOfDay(hour: 9, minute: 0);
    _endTime = existing != null
        ? TimeOfDay(hour: existing.endMinutes ~/ 60, minute: existing.endMinutes % 60)
        : const TimeOfDay(hour: 10, minute: 0);
    _selectedColor = existing != null ? Color(existing.colorValue) : _colorOptions[0];
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _pickTime(bool isStart) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isStart ? _startTime : _endTime,
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
    }
  }

  void _handleSave() {
    if (!_formKey.currentState!.validate()) return;

    final startMinutes = _startTime.hour * 60 + _startTime.minute;
    final endMinutes = _endTime.hour * 60 + _endTime.minute;

    if (endMinutes <= startMinutes) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('End time must be after start time')),
      );
      return;
    }

    final entry = TimetableEntryModel(
      id: widget.existingEntry?.id ?? '',
      subject: _subjectController.text.trim(),
      location: _locationController.text.trim(),
      dayOfWeek: _dayOfWeek,
      startMinutes: startMinutes,
      endMinutes: endMinutes,
      colorValue: _selectedColor.value,
    );

    Navigator.of(context).pop(entry);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                widget.existingEntry == null ? 'Add Class' : 'Edit Class',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _subjectController,
                decoration: const InputDecoration(
                  labelText: 'Subject',
                  prefixIcon: Icon(Icons.book_outlined),
                  border: OutlineInputBorder(),
                ),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Location / Room',
                  prefixIcon: Icon(Icons.location_on_outlined),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 14),
              DropdownButtonFormField<int>(
                initialValue: _dayOfWeek,
                decoration: const InputDecoration(
                  labelText: 'Day',
                  prefixIcon: Icon(Icons.calendar_today_outlined),
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 1, child: Text('Monday')),
                  DropdownMenuItem(value: 2, child: Text('Tuesday')),
                  DropdownMenuItem(value: 3, child: Text('Wednesday')),
                  DropdownMenuItem(value: 4, child: Text('Thursday')),
                  DropdownMenuItem(value: 5, child: Text('Friday')),
                  DropdownMenuItem(value: 6, child: Text('Saturday')),
                  DropdownMenuItem(value: 7, child: Text('Sunday')),
                ],
                onChanged: (value) {
                  if (value != null) setState(() => _dayOfWeek = value);
                },
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _pickTime(true),
                      icon: const Icon(Icons.access_time),
                      label: Text('Start: ${_startTime.format(context)}'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _pickTime(false),
                      icon: const Icon(Icons.access_time_filled),
                      label: Text('End: ${_endTime.format(context)}'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Color', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 10,
                children: _colorOptions.map((color) {
                  final isSelected = color.value == _selectedColor.value;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedColor = color),
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: color,
                      child: isSelected
                          ? const Icon(Icons.check, color: Colors.white, size: 18)
                          : null,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: _handleSave,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}