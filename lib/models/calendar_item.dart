import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

enum CalendarItemType { classSession, task, assignment, reminder, event }

/// A unified, display-only wrapper for a TimetableEntryModel, 
/// TaskModel, or CalendarEventModel. Created from these models 
/// on each screen build rather than stored separately.
class CalendarItem {
  final String sourceId;
  final CalendarItemType type;
  final String title;
  final String? subtitle;
  final DateTime date;
  final int? startMinutes; // null = all-day / no specific time
  final int? endMinutes;
  final Color color;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const CalendarItem({
    required this.sourceId,
    required this.type,
    required this.title,
    this.subtitle,
    required this.date,
    this.startMinutes,
    this.endMinutes,
    required this.color,
    required this.onTap,
    required this.onDelete,
  });

  bool get isAllDay => startMinutes == null;

  IconData get icon {
    switch (type) {
      case CalendarItemType.classSession:
        return Icons.school_outlined;
      case CalendarItemType.task:
        return Icons.task_alt;
      case CalendarItemType.assignment:
        return Icons.assignment_outlined;
      case CalendarItemType.reminder:
        return Icons.notifications_outlined;
      case CalendarItemType.event:
        return Icons.event_outlined;
    }
  }

  String typeLabel(AppLocalizations l10n) {
    switch (type) {
      case CalendarItemType.classSession:
        return l10n.calendarClassLabel;
      case CalendarItemType.task:
        return l10n.calendarTaskLabel;
      case CalendarItemType.assignment:
        return l10n.categoryAssignment;
      case CalendarItemType.reminder:
        return l10n.categoryReminder;
      case CalendarItemType.event:
        return l10n.categoryEvent;
    }
  }
}