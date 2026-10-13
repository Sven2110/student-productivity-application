import '../l10n/app_localizations.dart';

/// Shared reminder lead-time options, used identically by Timetable
/// classes, Calendar events (Assignments/Reminders/Events), and Tasks.
/// Storing the resolved minutes value (not the enum index) in
/// Firestore keeps the stored data self-describing and stable even
/// if this enum's declaration order ever changes.
enum ReminderOffset { none, minutes5, minutes15, minutes30, hour1, day1 }

extension ReminderOffsetX on ReminderOffset {
  /// Null means "no reminder" — the value actually persisted to
  /// Firestore as reminderOffsetMinutes.
  int? get minutes {
    switch (this) {
      case ReminderOffset.none:
        return null;
      case ReminderOffset.minutes5:
        return 5;
      case ReminderOffset.minutes15:
        return 15;
      case ReminderOffset.minutes30:
        return 30;
      case ReminderOffset.hour1:
        return 60;
      case ReminderOffset.day1:
        return 1440;
    }
  }

  /// Display label. Takes AppLocalizations rather than a BuildContext
  /// directly, so this stays trivial to call from anywhere you
  /// already have `l10n` handy (dropdown item builders, etc.).
  String label(AppLocalizations l10n) {
    switch (this) {
      case ReminderOffset.none:
        return l10n.reminderNone;
      case ReminderOffset.minutes5:
        return l10n.reminderMinutes5;
      case ReminderOffset.minutes15:
        return l10n.reminderMinutes15;
      case ReminderOffset.minutes30:
        return l10n.reminderMinutes30;
      case ReminderOffset.hour1:
        return l10n.reminderHour1;
      case ReminderOffset.day1:
        return l10n.reminderDay1;
    }
  }

  static ReminderOffset fromMinutes(int? minutes) {
    switch (minutes) {
      case null:
        return ReminderOffset.none;
      case 5:
        return ReminderOffset.minutes5;
      case 15:
        return ReminderOffset.minutes15;
      case 30:
        return ReminderOffset.minutes30;
      case 60:
        return ReminderOffset.hour1;
      case 1440:
        return ReminderOffset.day1;
      default:
        return ReminderOffset.none;
    }
  }
}