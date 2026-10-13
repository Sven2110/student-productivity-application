import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/calendar_event_model.dart';

class CalendarEventService {
  CollectionReference _eventsRef(String uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('calendar_events');
  }

  Stream<List<CalendarEventModel>> watchEvents(String uid) {
    return _eventsRef(uid).snapshots().map((snapshot) {
      final events =
          snapshot.docs.map((doc) => CalendarEventModel.fromFirestore(doc)).toList();
      events.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      return events;
    });
  }

  Future<String> addEvent(String uid, CalendarEventModel event) async {
    final docRef = await _eventsRef(uid).add(event.toFirestore());
    return docRef.id;
  }

  Future<void> updateEvent(String uid, CalendarEventModel event) async {
    await _eventsRef(uid).doc(event.id).update(event.toFirestore());
  }

  Future<void> deleteEvent(String uid, String eventId) async {
    await _eventsRef(uid).doc(eventId).delete();
  }
}