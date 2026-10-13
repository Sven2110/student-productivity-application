import 'package:flutter/material.dart';

/// Infinite horizontally-swipeable day pager. Wraps PageView.builder
/// over a very wide (~200 year) window of days, anchored so that
/// [initialDate] is the page shown when this widget is first built.
///
/// The parent is expected to give this widget a fresh key whenever
/// the date changes from an EXTERNAL source (tapping the week strip,
/// "Jump to Today", or navigating in from Month/Year view) — that
/// remounts the pager correctly anchored to the new date. Swiping
/// itself doesn't need a remount; it just reports the new date via
/// [onDateChanged] as the user swipes past a page boundary.
class DayPageView extends StatefulWidget {
  final DateTime initialDate;
  final Widget Function(DateTime date) contentBuilder;
  final void Function(DateTime date) onDateChanged;

  const DayPageView({
    super.key,
    required this.initialDate,
    required this.contentBuilder,
    required this.onDateChanged,
  });

  @override
  State<DayPageView> createState() => _DayPageViewState();
}

class _DayPageViewState extends State<DayPageView> {
  // Wide enough to feel unlimited in both directions for real use.
  static final DateTime _epoch = DateTime(DateTime.now().year - 100, 1, 1);
  static const int _totalDays = 200 * 365 + 60;

  late final PageController _controller;
  late final int _initialIndex;

  int _dateToIndex(DateTime date) {
    final normalized = DateTime(date.year, date.month, date.day);
    return normalized.difference(_epoch).inDays;
  }

  DateTime _indexToDate(int index) => _epoch.add(Duration(days: index));

  @override
  void initState() {
    super.initState();
    _initialIndex = _dateToIndex(widget.initialDate);
    _controller = PageController(initialPage: _initialIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _controller,
      itemCount: _totalDays,
      onPageChanged: (index) => widget.onDateChanged(_indexToDate(index)),
      itemBuilder: (context, index) => widget.contentBuilder(_indexToDate(index)),
    );
  }
}