import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/note_model.dart';
import '../../models/attachment_model.dart';

class NoteService {
  CollectionReference _notesRef(String uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('notes');
  }

  Stream<List<NoteModel>> watchNotes(String uid) {
    return _notesRef(uid).snapshots().map((snapshot) {
      final notes = snapshot.docs.map((doc) => NoteModel.fromFirestore(doc)).toList();
      notes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      return notes;
    });
  }

  Future<String> addNote(String uid, NoteModel note) async {
    final docRef = await _notesRef(uid).add(note.toFirestore());
    return docRef.id;
  }

  Future<void> updateNote(String uid, NoteModel note) async {
    await _notesRef(uid).doc(note.id).update(note.toFirestore());
  }

  Future<void> deleteNote(String uid, String noteId) async {
    await _notesRef(uid).doc(noteId).delete();
  }

  /// Persists the full attachments list — called after any add/remove
  /// via AttachmentService, which already computed the new list.
  Future<void> updateAttachments(
    String uid,
    String noteId,
    List<AttachmentModel> attachments,
  ) async {
    await _notesRef(uid).doc(noteId).update({
      'attachments': attachments.map((a) => a.toMap()).toList(),
    });
  }
}