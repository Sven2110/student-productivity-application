import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

enum CalendarEventCategory { assignment, reminder, event }

extension CalendarEventCategoryDisplay on CalendarEventCategory {
  String label(AppLocalizations l10n) {
    switch (this) {
      case CalendarEventCategory.assignment:
        return l10n.categoryAssignment;
      case CalendarEventCategory.reminder:
        return l10n.categoryReminder;
      case CalendarEventCategory.event:
        return l10n.categoryEvent;
    }
  }

  IconData get icon {
    switch (this) {
      case CalendarEventCategory.assignment:
        return Icons.assignment_outlined;
      case CalendarEventCategory.reminder:
        return Icons.notifications_outlined;
      case CalendarEventCategory.event:
        return Icons.event_outlined;
    }
  }
}

class CalendarEventModel {
  final String id;
  final String title;
  final String description;
  final CalendarEventCategory category;
  final DateTime date;
  final bool isAllDay;
  final int? startMinutes;
  final int? endMinutes;
  final int colorValue;
  /// Minutes before [dateTime] the reminder notification fires.
  /// Null = no reminder.
  final int? reminderOffsetMinutes;

  const CalendarEventModel({
    required this.id,
    required this.title,
    this.description = '',
    required this.category,
    required this.date,
    this.isAllDay = false,
    this.startMinutes,
    this.endMinutes,
    required this.colorValue,
    this.reminderOffsetMinutes,
  });

  Color get color => Color(colorValue);

  DateTime get dateTime {
    if (startMinutes == null) return DateTime(date.year, date.month, date.day);
    return DateTime(
      date.year, date.month, date.day,
      startMinutes! ~/ 60, startMinutes! % 60,
    );
  }

  factory CalendarEventModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
   // Backward compatibility: if the old `reminderEnabled` field was true,
   // default to a 15-minute reminder so existing reminders aren't lost.
    int? offset;
    if (data.containsKey('reminderOffsetMinutes')) {
      offset = data['reminderOffsetMinutes'] as int?;
    } else if (data['reminderEnabled'] == true) {
      offset = 0;
    }

    return CalendarEventModel(
      id: doc.id,
      title: data['title'] as String? ?? '',
      description: data['description'] as String? ?? '',
      category: CalendarEventCategory.values[data['category'] as int? ?? 2],
      date: (data['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
      isAllDay: data['isAllDay'] as bool? ?? false,
      startMinutes: data['startMinutes'] as int?,
      endMinutes: data['endMinutes'] as int?,
      colorValue: data['colorValue'] as int? ?? 0xFF4F46E5,
      reminderOffsetMinutes: offset,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'category': category.index,
      'date': Timestamp.fromDate(DateTime(date.year, date.month, date.day)),
      'isAllDay': isAllDay,
      'startMinutes': startMinutes,
      'endMinutes': endMinutes,
      'colorValue': colorValue,
      'reminderOffsetMinutes': reminderOffsetMinutes,
    };
  }
}