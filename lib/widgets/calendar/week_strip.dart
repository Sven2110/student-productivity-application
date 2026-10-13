import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// A compact 7-day strip for fast date switching within the current
/// week, with prev/next arrows to move a week at a time — the quick
/// "agenda planner" style date picker shown above the day's schedule.
class WeekStrip extends StatelessWidget {
  final DateTime selectedDate;
  final bool Function(DateTime date) hasItems;
  final void Function(DateTime date) onDateSelected;
  final VoidCallback onPrevWeek;
  final VoidCallback onNextWeek;

  const WeekStrip({
    super.key,
    required this.selectedDate,
    required this.hasItems,
    required this.onDateSelected,
    required this.onPrevWeek,
    required this.onNextWeek,
  });

  /// Locale-aware single-letter weekday initials (M T W T F S S in
  /// en, but the correct abbreviation for ja/zh/de/etc.), built from
  /// a real Monday-start reference week via intl.
  List<String> _dayLetters(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final mondayRef = DateTime(2024, 1, 1); // a Monday
    return List.generate(7, (i) {
      final full = DateFormat.E(locale).format(mondayRef.add(Duration(days: i)));
      return full.substring(0, full.length > 1 ? 1 : full.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    final dayLetters = _dayLetters(context);
    // Monday of the week containing selectedDate.
    final monday = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    final now = DateTime.now();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left, size: 20),
            onPressed: onPrevWeek,
            visualDensity: VisualDensity.compact,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(7, (i) {
                final date = monday.add(Duration(days: i));
                final isSelected = date.year == selectedDate.year &&
                    date.month == selectedDate.month &&
                    date.day == selectedDate.day;
                final isToday =
                    date.year == now.year && date.month == now.month && date.day == now.day;
                final itemsOnDay = hasItems(date);

                return GestureDetector(
                  onTap: () => onDateSelected(date),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        dayLetters[i],
                        style: TextStyle(fontSize: 11, color: Colors.grey.shade500, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: 36,
                        height: 36,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected
                              ? const Color(0xFF4F46E5)
                              : isToday
                                  ? const Color(0xFF4F46E5).withValues(alpha: 0.12)
                                  : Colors.transparent,
                        ),
                        child: Text(
                          '${date.day}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: isSelected || isToday ? FontWeight.bold : FontWeight.normal,
                            color: isSelected
                                ? Colors.white
                                : isToday
                                    ? const Color(0xFF4F46E5)
                                    : Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(height: 3),
                      SizedBox(
                        height: 4,
                        width: 4,
                        child: itemsOnDay && !isSelected
                            ? const DecoratedBox(
                                decoration: BoxDecoration(color: Color(0xFF16A34A), shape: BoxShape.circle),
                              )
                            : null,
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right, size: 20),
            onPressed: onNextWeek,
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}