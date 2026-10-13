import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/note_provider.dart';
import '../../widgets/notes/note_card.dart';
import 'note_editor_screen.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final noteProvider = context.watch<NoteProvider>();
    final notes = noteProvider.filteredNotes;
    final subjects = noteProvider.subjectsWithNotes;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.notesTitle)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => context.read<NoteProvider>().setSearchQuery(value),
              decoration: InputDecoration(
                hintText: l10n.notesSearchHint,
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
          if (subjects.isNotEmpty)
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _FilterChip(
                    label: l10n.filterAll,
                    selected: noteProvider.subjectFilter == null,
                    onTap: () => context.read<NoteProvider>().setSubjectFilter(null),
                  ),
                  ...subjects.map((subject) => _FilterChip(
                        label: subject,
                        selected: noteProvider.subjectFilter == subject,
                        onTap: () => context.read<NoteProvider>().setSubjectFilter(subject),
                      )),
                ],
              ),
            ),
          const SizedBox(height: 8),
          Expanded(
            child: noteProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : notes.isEmpty
                    ? Center(
                        child: Text(
                          noteProvider.notes.isEmpty ? l10n.notesEmpty : l10n.notesNoMatch,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: notes.length,
                        itemBuilder: (context, i) {
                          final note = notes[i];
                          return NoteCard(
                            note: note,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => NoteEditorScreen(existingNote: note),
                                ),
                              );
                            },
                            onDelete: () {
                              context.read<NoteProvider>().deleteNote(note.id);
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const NoteEditorScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
      ),
    );
  }
}