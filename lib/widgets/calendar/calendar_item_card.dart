import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../models/calendar_item.dart';

class CalendarItemCard extends StatelessWidget {
  final CalendarItem item;
  final Future<void> Function(CalendarItem item) onDeleteRequested;

  const CalendarItemCard({super.key, required this.item, required this.onDeleteRequested});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final timeLabel = item.isAllDay
        ? l10n.calendarAllDay
        : '${(item.startMinutes! ~/ 60).toString().padLeft(2, '0')}:${(item.startMinutes! % 60).toString().padLeft(2, '0')}';

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: item.color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
      ),
      child: InkWell(
        onTap: item.onTap,
        borderRadius: BorderRadius.circular(14),
        child: Row(
          children: [
            Container(
              width: 5,
              height: 56,
              decoration: BoxDecoration(
                color: item.color,
                borderRadius: const BorderRadius.horizontal(left: Radius.circular(14)),
              ),
            ),
            const SizedBox(width: 10),
            CircleAvatar(
              radius: 16,
              backgroundColor: item.color.withValues(alpha: 0.18),
              child: Icon(item.icon, size: 16, color: item.color),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                    if (item.subtitle != null)
                      Text(item.subtitle!, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                    const SizedBox(height: 2),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: item.color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        item.typeLabel(l10n),
                        style: TextStyle(fontSize: 10, color: item.color, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(timeLabel, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
            IconButton(
              icon: Icon(Icons.delete_outline, size: 18, color: Colors.grey.shade500),
              onPressed: () => onDeleteRequested(item),
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
      ),
    );
  }
}