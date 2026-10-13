import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TimetableEntryModel {
  final String id;
  final String subject;
  final String location;
  final int dayOfWeek;
  final int startMinutes;
  final int endMinutes;
  final int colorValue;
  /// Number of minutes before class starts when the reminder fires.
  /// Null means no reminder. Defaults to 15 for entries created before
  /// this field was introduced (see fromFirestore) to preserve
  /// existing behavior.
  final int? reminderOffsetMinutes;

  const TimetableEntryModel({
    required this.id,
    required this.subject,
    required this.location,
    required this.dayOfWeek,
    required this.startMinutes,
    required this.endMinutes,
    required this.colorValue,
    this.reminderOffsetMinutes = 15,
  });

  Color get color => Color(colorValue);

  TimeOfDay get startTime =>
      TimeOfDay(hour: startMinutes ~/ 60, minute: startMinutes % 60);

  TimeOfDay get endTime =>
      TimeOfDay(hour: endMinutes ~/ 60, minute: endMinutes % 60);

  String get dayName => const [
        'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday',
      ][dayOfWeek - 1];

  static String formatMinutes(int minutes) {
    final h = (minutes ~/ 60).toString().padLeft(2, '0');
    final m = (minutes % 60).toString().padLeft(2, '0');
    return '$h:$m';
  }

  String get timeRangeLabel =>
      '${formatMinutes(startMinutes)} - ${formatMinutes(endMinutes)}';

  factory TimetableEntryModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TimetableEntryModel(
      id: doc.id,
      subject: data['subject'] as String? ?? '',
      location: data['location'] as String? ?? '',
      dayOfWeek: data['dayOfWeek'] as int? ?? 1,
      startMinutes: data['startMinutes'] as int? ?? 0,
      endMinutes: data['endMinutes'] as int? ?? 0,
      colorValue: data['colorValue'] as int? ?? 0xFF4F46E5,
      // Entries created before this field was introduced won't contain the key.
      // Default to 15 to preserve their original hardcoded reminder behavior
      // instead of unintentionally disabling reminders.
      reminderOffsetMinutes: data.containsKey('reminderOffsetMinutes')
          ? data['reminderOffsetMinutes'] as int?
          : 15,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'subject': subject,
      'location': location,
      'dayOfWeek': dayOfWeek,
      'startMinutes': startMinutes,
      'endMinutes': endMinutes,
      'colorValue': colorValue,
      'reminderOffsetMinutes': reminderOffsetMinutes,
    };
  }
}