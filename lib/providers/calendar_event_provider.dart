import 'dart:async';
import 'package:flutter/foundation.dart';
import '../core/services/calendar_event_service.dart';
import '../core/services/notification_service.dart';
import '../models/calendar_event_model.dart';

class CalendarEventProvider extends ChangeNotifier {
  final CalendarEventService _service = CalendarEventService();

  StreamSubscription<List<CalendarEventModel>>? _subscription;
  List<CalendarEventModel> _events = [];
  String? _currentUid;
  bool _isLoading = false;
  String? _errorMessage;

  List<CalendarEventModel> get events => _events;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  List<CalendarEventModel> eventsOnDate(DateTime date) {
    return _events.where((e) =>
        e.date.year == date.year && e.date.month == date.month && e.date.day == date.day).toList();
  }

  void updateAuthUid(String? uid) {
    if (uid == _currentUid) return;
    _currentUid = uid;
    _subscription?.cancel();

    if (uid == null) {
      _events = [];
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    _subscription = _service.watchEvents(uid).listen(
      (events) {
        _events = events;
        _isLoading = false;
        notifyListeners();
      },
      onError: (error) {
        _errorMessage = 'Failed to load calendar events: $error';
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  /// Schedules the reminder AFTER the event is already saved, and
  /// never lets a notification/permission problem turn a successful
  /// save into a reported failure. A problem here only produces a
  /// warning message; the event itself stays saved.
  Future<void> _scheduleReminderSafely({
    required String id,
    required CalendarEventModel event,
    String? notificationTitle,
    String? notificationBody,
  }) async {
    try {
      await () async {
        await NotificationService().requestPermission();
        await NotificationService().scheduleOffsetReminder(
          id: id,
          title: notificationTitle ?? event.title,
          body: notificationBody ??
              (event.description.isNotEmpty ? event.description : event.title),
          targetDateTime: event.dateTime,
          offsetMinutes: event.reminderOffsetMinutes,
        );
        await _warnIfExactAlarmsUnavailable(event.reminderOffsetMinutes);
      }()
          .timeout(const Duration(seconds: 6), onTimeout: () {});
    } catch (e) {
      _errorMessage = 'Event saved, but the reminder could not be scheduled.';
      if (kDebugMode) debugPrint('[CalendarEventProvider] reminder failed: $e');
      notifyListeners();
    }
  }

  /// [notificationTitle] and [notificationBody] are built by the
  /// caller (which has a BuildContext and can reach AppLocalizations)
  /// — this provider has no context of its own, so it can't localize
  /// text itself. If omitted, falls back to the event's own title
  /// with no category prefix, which still works, just without the
  /// "Assignment: " / "Reminder: " / "Event: " prefix.
  Future<bool> addEvent(
    CalendarEventModel event, {
    String? notificationTitle,
    String? notificationBody,
  }) async {
    if (_currentUid == null) return false;
    _errorMessage = null;
    final String id;
    try {
      id = await _service.addEvent(_currentUid!, event);
    } catch (e) {
      _errorMessage = 'Failed to add event: $e';
      notifyListeners();
      return false;
    }
    await _scheduleReminderSafely(
      id: id,
      event: event,
      notificationTitle: notificationTitle,
      notificationBody: notificationBody,
    );
    return true;
  }

  Future<bool> updateEvent(
    CalendarEventModel event, {
    String? notificationTitle,
    String? notificationBody,
  }) async {
    if (_currentUid == null) return false;
    _errorMessage = null;
    try {
      await _service.updateEvent(_currentUid!, event);
    } catch (e) {
      _errorMessage = 'Failed to update event: $e';
      notifyListeners();
      return false;
    }
    await _scheduleReminderSafely(
      id: event.id,
      event: event,
      notificationTitle: notificationTitle,
      notificationBody: notificationBody,
    );
    return true;
  }

  Future<bool> deleteEvent(String eventId) async {
    if (_currentUid == null) return false;
    try {
      await _service.deleteEvent(_currentUid!, eventId);
    } catch (e) {
      _errorMessage = 'Failed to delete event: $e';
      notifyListeners();
      return false;
    }
    try {
      await NotificationService().cancelOffsetReminder(eventId);
    } catch (_) {
      // Event is already deleted; a stale reminder is not worth failing over.
    }
    return true;
  }

  Future<void> _warnIfExactAlarmsUnavailable(int? reminderOffsetMinutes) async {
    if (reminderOffsetMinutes != null &&
        !await NotificationService().canScheduleExactAlarms()) {
      _errorMessage =
          'Reminder saved, but exact alarms are disabled in system settings — it may fire late.';
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}