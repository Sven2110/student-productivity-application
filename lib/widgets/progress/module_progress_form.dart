import 'package:flutter/material.dart';
import '../../models/module_progress_model.dart';

class ModuleProgressForm extends StatefulWidget {
  final List<String> availableSubjects;

  const ModuleProgressForm({super.key, required this.availableSubjects});

  @override
  State<ModuleProgressForm> createState() => _ModuleProgressFormState();
}

class _ModuleProgressFormState extends State<ModuleProgressForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _customSubjectController;
  late TextEditingController _totalTopicsController;
  String? _selectedSubject;
  bool _useCustomSubject = false;

  @override
  void initState() {
    super.initState();
    _customSubjectController = TextEditingController();
    _totalTopicsController = TextEditingController(text: '10');
    if (widget.availableSubjects.isEmpty) {
      _useCustomSubject = true;
    } else {
      _selectedSubject = widget.availableSubjects.first;
    }
  }

  @override
  void dispose() {
    _customSubjectController.dispose();
    _totalTopicsController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (!_formKey.currentState!.validate()) return;

    final subject = _useCustomSubject
        ? _customSubjectController.text.trim()
        : (_selectedSubject ?? '');

    if (subject.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select or enter a subject')),
      );
      return;
    }

    final total = int.tryParse(_totalTopicsController.text.trim()) ?? 10;

    final module = ModuleProgressModel(
      id: '',
      subject: subject,
      totalTopics: total < 1 ? 1 : total,
      completedTopics: 0,
    );

    Navigator.of(context).pop(module);
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
              const Text(
                'Track New Subject',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              if (widget.availableSubjects.isNotEmpty) ...[
                DropdownButtonFormField<String>(
                  initialValue: _useCustomSubject ? null : _selectedSubject,
                  decoration: const InputDecoration(
                    labelText: 'Subject',
                    prefixIcon: Icon(Icons.book_outlined),
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    ...widget.availableSubjects.map(
                      (s) => DropdownMenuItem(value: s, child: Text(s)),
                    ),
                    const DropdownMenuItem(value: '__other__', child: Text('Other...')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      if (value == '__other__') {
                        _useCustomSubject = true;
                        _selectedSubject = null;
                      } else {
                        _useCustomSubject = false;
                        _selectedSubject = value;
                      }
                    });
                  },
                ),
                if (_useCustomSubject) const SizedBox(height: 14),
              ],

              if (_useCustomSubject)
                TextFormField(
                  controller: _customSubjectController,
                  decoration: const InputDecoration(
                    labelText: 'Subject name',
                    prefixIcon: Icon(Icons.edit_outlined),
                    border: OutlineInputBorder(),
                  ),
                ),

              const SizedBox(height: 14),
              TextFormField(
                controller: _totalTopicsController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Total topics / chapters in syllabus',
                  prefixIcon: Icon(Icons.format_list_numbered),
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  final n = int.tryParse(v ?? '');
                  if (n == null || n < 1) return 'Enter a number of at least 1';
                  return null;
                },
              ),

              const SizedBox(height: 24),
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: _handleSave,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Start Tracking'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}