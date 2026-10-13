import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:flutter_timezone/flutter_timezone.dart';
import '../../models/timetable_entry_model.dart';

class NotificationService {
  NotificationService._internal();
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;

    tz_data.initializeTimeZones();
    final locationName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(locationName));

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const darwinSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: darwinSettings,
      macOS: darwinSettings,
    );

    await _plugin.initialize(initSettings);
    _initialized = true;
  }

  /// Requests notification + exact-alarm permission. Safe to call
  /// repeatedly — called once at startup AND again right before any
  /// scheduling attempt (see the *Provider classes), since a user
  /// could revoke permission in system settings mid-session and we
  /// want scheduling to fail loudly rather than silently no-op.
  Future<void> requestPermission() async {
    final androidImpl = _plugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    final notifGranted = await androidImpl?.requestNotificationsPermission();
    final exactGranted = await androidImpl?.requestExactAlarmsPermission();
    if (kDebugMode) {
      debugPrint('[Notif] permission results: notifications=$notifGranted '
          'exactAlarms=$exactGranted');
    }

    final iosImpl = _plugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
    await iosImpl?.requestPermissions(alert: true, badge: true, sound: true);

    final macImpl = _plugin
        .resolvePlatformSpecificImplementation<MacOSFlutterLocalNotificationsPlugin>();
    await macImpl?.requestPermissions(alert: true, badge: true, sound: true);
  }

  /// Returns whether this device currently allows scheduling EXACT
  /// alarms — used by the *Provider classes to warn the user (via a
  /// snackbar) if a reminder was requested but can't actually be
  /// guaranteed to fire, rather than failing silently.
  Future<bool> canScheduleExactAlarms() async {
    final androidImpl = _plugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    return await androidImpl?.canScheduleExactNotifications() ?? true;
  }

  int notificationIdFor(String rawId) => rawId.hashCode & 0x7FFFFFFF;

  /// Schedules a WEEKLY RECURRING reminder for a timetable class,
  /// firing [entry.reminderOffsetMinutes] minutes before each
  /// occurrence. Does nothing (and cancels any existing one) if
  /// reminderOffsetMinutes is null.
  Future<void> scheduleReminderForEntry(TimetableEntryModel entry) async {
    final id = notificationIdFor(entry.id);
    await _plugin.cancel(id);

    final offset = entry.reminderOffsetMinutes;
    if (offset == null) return;

    final reminderTime = _nextOccurrence(entry, offset).subtract(Duration(minutes: offset));

    if (kDebugMode) {
      debugPrint('[Notif] scheduling class id=$id "${entry.subject}" for $reminderTime '
          '(now=${tz.TZDateTime.now(tz.local)})');
    }

    try {
      await _plugin.zonedSchedule(
        id,
        'Upcoming class: ${entry.subject}',
        entry.location.isNotEmpty
            ? 'Starts at ${TimetableEntryModel.formatMinutes(entry.startMinutes)} • ${entry.location}'
            : 'Starts at ${TimetableEntryModel.formatMinutes(entry.startMinutes)}',
        reminderTime,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'timetable_reminders',
            'Timetable Reminders',
            channelDescription: 'Reminders for upcoming classes',
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.alarmClock,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      );
    } catch (e, st) {
      if (kDebugMode) {
        debugPrint('[Notif] zonedSchedule FAILED for class id=$id: $e\n$st');
      }
      rethrow;
    }
  }

  Future<void> cancelReminderForEntry(String entryId) async {
    await _plugin.cancel(notificationIdFor(entryId));
  }

  /// Threshold used by [scheduleOffsetReminder] to decide whether a
  /// reminder time that has already passed is a negligible rounding/
  /// processing overshoot (safe to fire almost immediately) versus a
  /// genuine mismatch between the requested lead time and how soon
  /// the target actually is (e.g. a "1 day before" reminder on
  /// something due in 3 hours) — in which case firing immediately
  /// would be misleading, so it's skipped instead.
  static const Duration _maxOvershootToFireNow = Duration(minutes: 1);

  /// Generic ONE-OFF offset reminder — used identically by Calendar
  /// events (Assignments/Reminders/Events) and Tasks. Fires
  /// [offsetMinutes] before [targetDateTime]. Does nothing if
  /// offsetMinutes is null or [targetDateTime] itself has already
  /// passed. If the reminder time has only just barely passed (within
  /// [_maxOvershootToFireNow], e.g. rounding or processing delay) it
  /// fires almost immediately rather than being silently dropped. If
  /// it's passed by more than that — meaning the requested lead time
  /// (e.g. a full day) genuinely can't be honored given how soon the
  /// target is — scheduling is skipped entirely instead of firing a
  /// misleadingly early/instant notification.
  Future<void> scheduleOffsetReminder({
    required String id,
    required String title,
    required String body,
    required DateTime targetDateTime,
    required int? offsetMinutes,
  }) async {
    final notificationId = notificationIdFor(id);
    await _plugin.cancel(notificationId);

    if (offsetMinutes == null) return;
    if (!targetDateTime.isAfter(DateTime.now())) return;

    var reminderTime = targetDateTime.subtract(Duration(minutes: offsetMinutes));
    final now = DateTime.now();
    if (reminderTime.isBefore(now)) {
      final overshoot = now.difference(reminderTime);
      if (overshoot <= _maxOvershootToFireNow) {
        reminderTime = now.add(const Duration(seconds: 5));
      } else {
        if (kDebugMode) {
          debugPrint('[Notif] skipped id=$notificationId "$title" — reminder '
              'time was $overshoot in the past (requested $offsetMinutes min '
              'lead time on a target that is sooner than that), not firing '
              'immediately to avoid a misleading early alert');
        }
        return;
      }
    }

    final scheduledTz = tz.TZDateTime.from(reminderTime, tz.local);

    if (kDebugMode) {
      debugPrint(
          '[Notif] scheduling id=$notificationId "$title" for $scheduledTz '
          '(now=${tz.TZDateTime.now(tz.local)}, tz=${tz.local.name})');
    }

    try {
      await _plugin.zonedSchedule(
        notificationId,
        title,
        body,
        scheduledTz,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'calendar_reminders',
            'Calendar Reminders',
            channelDescription: 'Reminders for assignments, events, reminders, and tasks',
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.alarmClock,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    } catch (e, st) {
      if (kDebugMode) {
        debugPrint('[Notif] zonedSchedule FAILED for id=$notificationId: $e\n$st');
      }
      rethrow;
    }

    if (kDebugMode) {
      final pending = await _plugin.pendingNotificationRequests();
      final match = pending.where((p) => p.id == notificationId).toList();
      debugPrint('[Notif] pending after schedule: id=$notificationId '
          'registered=${match.isNotEmpty} totalPending=${pending.length}');
    }
  }

  Future<void> cancelOffsetReminder(String id) async {
    await _plugin.cancel(notificationIdFor(id));
  }

  Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }

  /// Finds the next occurrence of [entry] whose reminder (i.e.
  /// [offsetMinutes] before class start) hasn't already passed. This
  /// is deliberately stricter than just "next occurrence in the
  /// future" — anchoring a recurring (matchDateTimeComponents) alarm
  /// on a start time whose reminder is already in the past causes it
  /// to misfire immediately on Android instead of waiting for the
  /// correct weekly slot.
  tz.TZDateTime _nextOccurrence(TimetableEntryModel entry, int offsetMinutes) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local, now.year, now.month, now.day,
      entry.startMinutes ~/ 60, entry.startMinutes % 60,
    );

    while (scheduled.weekday != entry.dayOfWeek ||
        scheduled.subtract(Duration(minutes: offsetMinutes)).isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    return scheduled;
  }
}