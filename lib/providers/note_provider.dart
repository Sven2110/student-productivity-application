import 'dart:async';
import 'package:flutter/foundation.dart';
import '../core/services/note_service.dart';
import '../models/note_model.dart';
import '../models/attachment_model.dart';

class NoteProvider extends ChangeNotifier {
  final NoteService _service = NoteService();

  StreamSubscription<List<NoteModel>>? _subscription;
  List<NoteModel> _notes = [];
  String? _currentUid;
  bool _isLoading = false;
  String? _errorMessage;

  String _searchQuery = '';
  String? _subjectFilter;

  List<NoteModel> get notes => _notes;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get subjectFilter => _subjectFilter;

  List<String> get subjectsWithNotes =>
      _notes.map((n) => n.subject).where((s) => s.isNotEmpty).toSet().toList()..sort();

  List<NoteModel> get filteredNotes {
    var result = _notes;
    if (_subjectFilter != null && _subjectFilter!.isNotEmpty) {
      result = result.where((n) => n.subject == _subjectFilter).toList();
    }
    if (_searchQuery.trim().isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      result = result
          .where((n) =>
              n.title.toLowerCase().contains(query) ||
              n.content.toLowerCase().contains(query))
          .toList();
    }
    return result;
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setSubjectFilter(String? subject) {
    _subjectFilter = subject;
    notifyListeners();
  }

  void updateAuthUid(String? uid) {
    if (uid == _currentUid) return;
    _currentUid = uid;
    _subscription?.cancel();

    if (uid == null) {
      _notes = [];
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    _subscription = _service.watchNotes(uid).listen(
      (notes) {
        _notes = notes;
        _isLoading = false;
        notifyListeners();
      },
      onError: (error) {
        _errorMessage = 'Failed to load notes: $error';
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<String?> addNote(NoteModel note) async {
    if (_currentUid == null) return null;
    try {
      return await _service.addNote(_currentUid!, note);
    } catch (e) {
      _errorMessage = 'Failed to add note: $e';
      notifyListeners();
      return null;
    }
  }

  Future<bool> updateNote(NoteModel note) async {
    if (_currentUid == null) return false;
    try {
      await _service.updateNote(_currentUid!, note);
      return true;
    } catch (e) {
      _errorMessage = 'Failed to update note: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteNote(String noteId) async {
    if (_currentUid == null) return false;
    try {
      await _service.deleteNote(_currentUid!, noteId);
      return true;
    } catch (e) {
      _errorMessage = 'Failed to delete note: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> persistAttachments(String noteId, List<AttachmentModel> attachments) async {
    if (_currentUid == null) return false;
    try {
      await _service.updateAttachments(_currentUid!, noteId, attachments);
      return true;
    } catch (e) {
      _errorMessage = 'Failed to update attachments: $e';
      notifyListeners();
      return false;
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}