import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/timetable_entry_model.dart';

class TimetableService {
  CollectionReference _timetableRef(String uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('timetable');
  }

  Stream<List<TimetableEntryModel>> watchEntries(String uid) {
    return _timetableRef(uid).snapshots().map((snapshot) {
      final entries = snapshot.docs
          .map((doc) => TimetableEntryModel.fromFirestore(doc))
          .toList();

      entries.sort((a, b) {
        final dayCompare = a.dayOfWeek.compareTo(b.dayOfWeek);
        if (dayCompare != 0) return dayCompare;
        return a.startMinutes.compareTo(b.startMinutes);
      });

      return entries;
    });
  }

  /// Returns the newly created document's ID, so the caller (the
  /// provider) can immediately schedule a notification tied to it
  /// without waiting for the next snapshot to come back around.
  Future<String> addEntry(String uid, TimetableEntryModel entry) async {
    final docRef = await _timetableRef(uid).add(entry.toFirestore());
    return docRef.id;
  }

  Future<void> updateEntry(String uid, TimetableEntryModel entry) async {
    await _timetableRef(uid).doc(entry.id).update(entry.toFirestore());
  }

  Future<void> deleteEntry(String uid, String entryId) async {
    await _timetableRef(uid).doc(entryId).delete();
  }
}