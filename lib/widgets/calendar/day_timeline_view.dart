import 'package:flutter/material.dart';
import '../../models/calendar_item.dart';

class DayTimelineView extends StatefulWidget {
  final List<CalendarItem> items;
  final void Function(int hour) onTapEmptySlot;
  final Future<void> Function(CalendarItem item) onDeleteRequested;

  static const double hourHeight = 64;

  const DayTimelineView({
    super.key,
    required this.items,
    required this.onTapEmptySlot,
    required this.onDeleteRequested,
  });

  @override
  State<DayTimelineView> createState() => _DayTimelineViewState();
}

class _DayTimelineViewState extends State<DayTimelineView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Auto-scroll to a sensible starting point so today's schedule
    // is visible immediately, instead of opening at midnight and
    // requiring the user to manually scroll down to find anything —
    // which was easy to mistake for items being "in the wrong place".
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToRelevantHour());
  }

  @override
  void didUpdateWidget(DayTimelineView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items) {
      _scrollToRelevantHour();
    }
  }

  void _scrollToRelevantHour() {
    if (!_scrollController.hasClients) return;

    final timedItems = widget.items.where((i) => !i.isAllDay).toList();
    // Scroll to just before the earliest scheduled item, or 7 AM by
    // default if nothing's scheduled — either way, never leaves the
    // user staring at an empty midnight-to-dawn stretch.
    final earliestMinutes = timedItems.isEmpty
        ? 7 * 60
        : timedItems.map((i) => i.startMinutes!).reduce((a, b) => a < b ? a : b);

    final targetOffset =
        ((earliestMinutes - 60).clamp(0, 24 * 60) / 60) * DayTimelineView.hourHeight;

    _scrollController.jumpTo(targetOffset.clamp(
      0,
      _scrollController.position.maxScrollExtent,
    ));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allDayItems = widget.items.where((i) => i.isAllDay).toList();
    final timedItems = widget.items.where((i) => !i.isAllDay).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (allDayItems.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: allDayItems
                  .map((item) => _AllDayChip(item: item, onDeleteRequested: widget.onDeleteRequested))
                  .toList(),
            ),
          ),
        Expanded(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: SizedBox(
              height: DayTimelineView.hourHeight * 24,
              child: Stack(
                children: [
                  // Full-width hour grid — crossAxisAlignment.stretch
                  // ensures each row's border/background spans the
                  // entire row width, not just the time-label column,
                  // so there's a clear visual guide lining up with
                  // where the event blocks (left: 60) actually sit.
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: List.generate(24, (hour) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => widget.onTapEmptySlot(hour),
                        child: Container(
                          height: DayTimelineView.hourHeight,
                          decoration: BoxDecoration(
                            border: Border(top: BorderSide(color: Colors.grey.shade100)),
                          ),
                          padding: const EdgeInsets.only(top: 4, left: 8),
                          child: Text(
                            '${hour.toString().padLeft(2, '0')}:00',
                            style: TextStyle(fontSize: 11, color: Colors.grey.shade400),
                          ),
                        ),
                      );
                    }),
                  ),
                  ...timedItems.map((item) {
                    final start = item.startMinutes!;
                    final end = item.endMinutes ?? (start + 30);
                    final top = (start / 60) * DayTimelineView.hourHeight;
                    final height = ((end - start) / 60) * DayTimelineView.hourHeight;

                    return Positioned(
                      top: top,
                      left: 60,
                      right: 8,
                      height: height < 40 ? 40 : height,
                      child: _AgendaBlock(item: item, onDeleteRequested: widget.onDeleteRequested),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AgendaBlock extends StatelessWidget {
  final CalendarItem item;
  final Future<void> Function(CalendarItem item) onDeleteRequested;

  const _AgendaBlock({required this.item, required this.onDeleteRequested});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: item.onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 3),
        decoration: BoxDecoration(
          color: item.color.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              width: 4,
              decoration: BoxDecoration(
                color: item.color,
                borderRadius: const BorderRadius.horizontal(left: Radius.circular(10)),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Row(
                  children: [
                    Icon(item.icon, size: 14, color: item.color),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            item.title,
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: item.color),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (item.subtitle != null)
                            Text(
                              item.subtitle!,
                              style: TextStyle(fontSize: 10, color: item.color.withValues(alpha: 0.8)),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () => onDeleteRequested(item),
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Icon(Icons.delete_outline, size: 16, color: item.color.withValues(alpha: 0.7)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AllDayChip extends StatelessWidget {
  final CalendarItem item;
  final Future<void> Function(CalendarItem item) onDeleteRequested;

  const _AllDayChip({required this.item, required this.onDeleteRequested});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: item.color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: item.onTap,
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 6, bottom: 6, right: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(item.icon, size: 14, color: item.color),
                  const SizedBox(width: 6),
                  Text(item.title, style: TextStyle(fontSize: 12, color: item.color, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () => onDeleteRequested(item),
            borderRadius: const BorderRadius.horizontal(right: Radius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.only(right: 8, left: 2, top: 6, bottom: 6),
              child: Icon(Icons.close, size: 14, color: item.color),
            ),
          ),
        ],
      ),
    );
  }
}