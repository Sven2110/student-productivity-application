import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/timetable_provider.dart';
import '../../providers/task_provider.dart';
import '../../providers/calendar_event_provider.dart';
import '../../models/calendar_item.dart';
import '../../models/calendar_event_model.dart';
import '../../models/timetable_entry_model.dart';
import '../../widgets/calendar/day_timeline_view.dart';
import '../../widgets/calendar/calendar_item_card.dart';
import '../../widgets/calendar/calendar_event_form.dart';
import '../../widgets/calendar/week_strip.dart';
import '../../widgets/calendar/day_page_view.dart';
import '../../widgets/timetable/timetable_entry_form.dart';
import '../../widgets/tasks/task_form.dart';

enum _ViewMode { day, week, month, year }

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  _ViewMode _viewMode = _ViewMode.day;
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();

  static final DateTime _rangeStart = DateTime(DateTime.now().year - 100, 1, 1);
  static final DateTime _rangeEnd = DateTime(DateTime.now().year + 100, 12, 31);

  static final DateTime _yearListBase = DateTime(DateTime.now().year - 100, DateTime.now().month, 1);
  static const int _yearListMonthCount = 201 * 12;
  static final int _yearViewInitialIndex = 100 * 12;
  final ItemScrollController _yearScrollController = ItemScrollController();

  List<CalendarItem> _itemsForDate(BuildContext context, DateTime date) {
    final l10n = AppLocalizations.of(context)!;
    final items = <CalendarItem>[];

    final timetable = context.read<TimetableProvider>();
    for (final entry in timetable.entriesForDay(date.weekday)) {
      items.add(CalendarItem(
        sourceId: entry.id,
        type: CalendarItemType.classSession,
        title: entry.subject,
        subtitle: entry.location.isNotEmpty ? entry.location : null,
        date: date,
        startMinutes: entry.startMinutes,
        endMinutes: entry.endMinutes,
        color: entry.color,
        onTap: () => _openClassForm(existingEntry: entry, forDate: date),
        onDelete: () => context.read<TimetableProvider>().deleteEntry(entry.id),
      ));
    }

    final tasks = context.read<TaskProvider>();
    for (final task in tasks.tasks) {
      if (task.dueDate != null &&
          task.dueDate!.year == date.year &&
          task.dueDate!.month == date.month &&
          task.dueDate!.day == date.day) {
        items.add(CalendarItem(
          sourceId: task.id,
          type: CalendarItemType.task,
          title: task.title,
          subtitle: task.isCompleted ? l10n.calendarCompleted : l10n.calendarTaskDue,
          date: date,
          startMinutes: null,
          color: task.isCompleted ? Colors.grey : const Color(0xFF16A34A),
          onTap: () => _openTaskForm(existingTask: task),
          onDelete: () => context.read<TaskProvider>().deleteTask(task.id),
        ));
      }
    }

    final events = context.read<CalendarEventProvider>();
    for (final event in events.eventsOnDate(date)) {
      items.add(CalendarItem(
        sourceId: event.id,
        type: switch (event.category) {
          CalendarEventCategory.assignment => CalendarItemType.assignment,
          CalendarEventCategory.reminder => CalendarItemType.reminder,
          CalendarEventCategory.event => CalendarItemType.event,
        },
        title: event.title,
        subtitle: event.description.isNotEmpty ? event.description : null,
        date: date,
        startMinutes: event.isAllDay ? null : event.startMinutes,
        endMinutes: event.endMinutes,
        color: event.color,
        onTap: () => _openEventForm(existingEvent: event, forDate: date),
        onDelete: () => context.read<CalendarEventProvider>().deleteEvent(event.id),
      ));
    }

    items.sort((a, b) {
      if (a.isAllDay != b.isAllDay) return a.isAllDay ? -1 : 1;
      if (a.isAllDay) return 0;
      return a.startMinutes!.compareTo(b.startMinutes!);
    });

    return items;
  }

  bool _hasItemsOnDate(DateTime date) => _itemsForDate(context, date).isNotEmpty;
  int _itemCountForDate(DateTime date) => _itemsForDate(context, date).length;

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  Future<void> _handleDeleteRequest(CalendarItem item) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.calendarDeleteItemTitle(item.typeLabel(l10n).toLowerCase())),
        content: Text(l10n.calendarDeleteItemBody(item.title)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l10n.cancel)),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.delete, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      item.onDelete();
      setState(() {});
    }
  }

  Future<void> _openClassForm({TimetableEntryModel? existingEntry, DateTime? forDate}) async {
    final targetDate = forDate ?? _selectedDate;

    final result = await showModalBottomSheet<TimetableEntryModel>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => TimetableEntryForm(
        existingEntry: existingEntry,
        initialDay: targetDate.weekday,
      ),
    );
    if (result == null || !mounted) return;
    final l10n = AppLocalizations.of(context)!;

    final provider = context.read<TimetableProvider>();
    final success = existingEntry == null
        ? await provider.addEntry(result)
        : await provider.updateEntry(result);
    if ((!success || provider.errorMessage != null) && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(provider.errorMessage ?? l10n.somethingWentWrong)),
      );
    }
    setState(() {});
  }

  /// The task form saves the task (and its attachments) itself and
  /// shows its own error feedback, so nothing needs saving here. New
  /// tasks are pre-filled with the day currently selected in the
  /// calendar — a task without a due date would never appear on the
  /// calendar at all, which made it look like it hadn't been saved.
  Future<void> _openTaskForm({dynamic existingTask}) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => TaskForm(
        existingTask: existingTask,
        initialDueDate: existingTask == null ? _selectedDate : null,
      ),
    );
    if (mounted) setState(() {});
  }

  Future<void> _openEventForm({
    CalendarEventModel? existingEvent,
    CalendarEventCategory category = CalendarEventCategory.event,
    int? initialHour,
    DateTime? forDate,
  }) async {
    final targetDate = forDate ?? _selectedDate;

    final result = await showModalBottomSheet<CalendarEventModel>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => CalendarEventForm(
        existingEvent: existingEvent,
        initialCategory: existingEvent?.category ?? category,
        initialDate: targetDate,
        initialHour: initialHour,
      ),
    );
    if (result == null || !mounted) return;
    final l10n = AppLocalizations.of(context)!;

    final provider = context.read<CalendarEventProvider>();
    final notificationTitle = '${result.category.label(l10n)}: ${result.title}';
    final notificationBody = result.description.isNotEmpty ? result.description : result.title;
    final success = existingEvent == null
        ? await provider.addEvent(result, notificationTitle: notificationTitle, notificationBody: notificationBody)
        : await provider.updateEvent(result, notificationTitle: notificationTitle, notificationBody: notificationBody);
    if ((!success || provider.errorMessage != null) && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(provider.errorMessage ?? l10n.somethingWentWrong)),
      );
    }
    setState(() {});
  }

  Future<void> _showAddSheet() async {
    final l10n = AppLocalizations.of(context)!;
    final choice = await showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.school_outlined),
              title: Text(l10n.calendarAddClass),
              onTap: () => Navigator.pop(ctx, 'class'),
            ),
            ListTile(
              leading: const Icon(Icons.task_alt),
              title: Text(l10n.calendarAddTask),
              onTap: () => Navigator.pop(ctx, 'task'),
            ),
            ListTile(
              leading: const Icon(Icons.assignment_outlined),
              title: Text(l10n.calendarAddAssignment),
              onTap: () => Navigator.pop(ctx, 'assignment'),
            ),
            ListTile(
              leading: const Icon(Icons.notifications_outlined),
              title: Text(l10n.calendarAddReminder),
              onTap: () => Navigator.pop(ctx, 'reminder'),
            ),
            ListTile(
              leading: const Icon(Icons.event_outlined),
              title: Text(l10n.calendarAddEvent),
              onTap: () => Navigator.pop(ctx, 'event'),
            ),
          ],
        ),
      ),
    );

    if (choice == null) return;
    switch (choice) {
      case 'class':
        _openClassForm();
        break;
      case 'task':
        _openTaskForm();
        break;
      case 'assignment':
        _openEventForm(category: CalendarEventCategory.assignment);
        break;
      case 'reminder':
        _openEventForm(category: CalendarEventCategory.reminder);
        break;
      case 'event':
        _openEventForm(category: CalendarEventCategory.event);
        break;
    }
  }

  Widget _buildViewModeSelector(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SegmentedButton<_ViewMode>(
        segments: [
          ButtonSegment(value: _ViewMode.day, label: Text(l10n.calendarDay)),
          ButtonSegment(value: _ViewMode.week, label: Text(l10n.calendarWeek)),
          ButtonSegment(value: _ViewMode.month, label: Text(l10n.calendarMonth)),
          ButtonSegment(value: _ViewMode.year, label: Text(l10n.calendarYear)),
        ],
        selected: {_viewMode},
        onSelectionChanged: (selection) => setState(() => _viewMode = selection.first),
      ),
    );
  }

  /// Locale-aware header, e.g. "17 September" in en, "17 septembre"
  /// in fr, "9月17日" in ja — driven by intl's DateFormat instead of a
  /// hardcoded English month-name table.
  String _headerLabel(BuildContext context, AppLocalizations l10n, DateTime date) {
    final locale = Localizations.localeOf(context).toString();
    final now = DateTime.now();
    if (_isSameDay(date, now)) {
      return l10n.calendarToday(DateFormat.MMMd(locale).format(date));
    }
    return DateFormat.yMMMd(locale).format(date);
  }

  /// Day view: a fixed WeekStrip for quick-jumping, plus a swipeable
  /// DayPageView below it for natural left/right gesture navigation
  /// day-by-day — the same interaction pattern Week/Month already get
  /// for free from TableCalendar's own paging.
  Widget _buildDayView(AppLocalizations l10n) {
    return Column(
      children: [
        WeekStrip(
          selectedDate: _selectedDate,
          hasItems: _hasItemsOnDate,
          onDateSelected: (date) => setState(() => _selectedDate = date),
          onPrevWeek: () => setState(() => _selectedDate = _selectedDate.subtract(const Duration(days: 7))),
          onNextWeek: () => setState(() => _selectedDate = _selectedDate.add(const Duration(days: 7))),
        ),
        Expanded(
          // Remounts (fresh anchor) only when _selectedDate changes
          // from an EXTERNAL source (week strip tap, Jump to Today).
          // Swiping itself updates _selectedDate via onDateChanged
          // without needing a remount mid-gesture.
          child: DayPageView(
            key: ValueKey(_selectedDate),
            initialDate: _selectedDate,
            onDateChanged: (date) => setState(() => _selectedDate = date),
            contentBuilder: (date) {
              final items = _itemsForDate(context, date);
              final dateIsToday = _isSameDay(date, DateTime.now());

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _headerLabel(context, l10n, date),
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        if (!dateIsToday)
                          TextButton(
                            onPressed: () => setState(() => _selectedDate = DateTime.now()),
                            child: Text(l10n.calendarJumpToToday),
                          ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: DayTimelineView(
                      items: items,
                      onTapEmptySlot: (hour) => _openEventForm(initialHour: hour, forDate: date),
                      onDeleteRequested: _handleDeleteRequest,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildWeekView(AppLocalizations l10n) {
    return Column(
      children: [
        WeekStrip(
          selectedDate: _selectedDate,
          hasItems: _hasItemsOnDate,
          onDateSelected: (date) => setState(() {
            _selectedDate = date;
            _focusedDate = date;
          }),
          onPrevWeek: () => setState(() {
            _selectedDate = _selectedDate.subtract(const Duration(days: 7));
            _focusedDate = _selectedDate;
          }),
          onNextWeek: () => setState(() {
            _selectedDate = _selectedDate.add(const Duration(days: 7));
            _focusedDate = _selectedDate;
          }),
        ),
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              _headerLabel(context, l10n, _selectedDate),
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          child: DayTimelineView(
            key: ValueKey(_selectedDate),
            items: _itemsForDate(context, _selectedDate),
            onTapEmptySlot: (hour) => _openEventForm(initialHour: hour, forDate: _selectedDate),
            onDeleteRequested: _handleDeleteRequest,
          ),
        ),
      ],
    );
  }

  Widget _buildMonthView(AppLocalizations l10n) {
    final items = _itemsForDate(context, _selectedDate);
    return Column(
      children: [
        TableCalendar(
          locale: Localizations.localeOf(context).toString(),
          firstDay: _rangeStart,
          lastDay: _rangeEnd,
          focusedDay: _focusedDate,
          calendarFormat: CalendarFormat.month,
          selectedDayPredicate: (day) => isSameDay(day, _selectedDate),
          headerStyle: const HeaderStyle(formatButtonVisible: false),
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, day, focusedDay) {
              if (!_hasItemsOnDate(day)) return null;
              return Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFF4F46E5).withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text('${day.day}', style: const TextStyle(color: Color(0xFF4F46E5), fontWeight: FontWeight.w600)),
              );
            },
          ),
          onDaySelected: (selected, focused) {
            setState(() {
              _selectedDate = selected;
              _focusedDate = focused;
            });
          },
          onPageChanged: (focused) => setState(() => _focusedDate = focused),
        ),
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              _headerLabel(context, l10n, _selectedDate),
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          child: items.isEmpty
              ? Center(child: Text(l10n.calendarNothingScheduled, style: const TextStyle(color: Colors.grey)))
              : ListView(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                  children: items
                      .map((item) => CalendarItemCard(item: item, onDeleteRequested: _handleDeleteRequest))
                      .toList(),
                ),
        ),
      ],
    );
  }

  Widget _buildYearView() {
    return ScrollablePositionedList.builder(
      itemScrollController: _yearScrollController,
      initialScrollIndex: _yearViewInitialIndex,
      itemCount: _yearListMonthCount,
      itemBuilder: (context, index) {
        final monthDate = DateTime(_yearListBase.year, _yearListBase.month + index, 1);
        return _MonthBlock(
          monthDate: monthDate,
          itemCountForDate: _itemCountForDate,
          onMonthHeaderTap: () {
            setState(() {
              _focusedDate = monthDate;
              _viewMode = _ViewMode.month;
            });
          },
          onDayTap: (date) {
            setState(() {
              _selectedDate = date;
              _focusedDate = date;
              _viewMode = _ViewMode.day;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    context.watch<TimetableProvider>();
    context.watch<TaskProvider>();
    context.watch<CalendarEventProvider>();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.calendarTitle)),
      body: Column(
        children: [
          _buildViewModeSelector(l10n),
          Expanded(
            child: switch (_viewMode) {
              _ViewMode.day => _buildDayView(l10n),
              _ViewMode.week => _buildWeekView(l10n),
              _ViewMode.month => _buildMonthView(l10n),
              _ViewMode.year => _buildYearView(),
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddSheet,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _MonthBlock extends StatelessWidget {
  final DateTime monthDate;
  final int Function(DateTime date) itemCountForDate;
  final VoidCallback onMonthHeaderTap;
  final void Function(DateTime date) onDayTap;

  const _MonthBlock({
    required this.monthDate,
    required this.itemCountForDate,
    required this.onMonthHeaderTap,
    required this.onDayTap,
  });

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final year = monthDate.year;
    final month = monthDate.month;
    final firstDayOfMonth = DateTime(year, month, 1);
    final daysInMonth = DateTime(year, month + 1, 0).day;
    final leadingBlanks = firstDayOfMonth.weekday - 1;

    final now = DateTime.now();
    final isCurrentMonth = now.year == year && now.month == month;

    // Locale-aware weekday initials (M T W T F S S in en, but the
    // correct single/double-character abbreviation in ja/zh/de/etc.),
    // built from a real Monday-start reference week instead of a
    // hardcoded English list.
    final mondayRef = DateTime(2024, 1, 1); // a Monday
    final weekdayLabels = List.generate(7, (i) {
      final full = DateFormat.E(locale).format(mondayRef.add(Duration(days: i)));
      return full.substring(0, full.length > 1 ? 1 : full.length);
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: onMonthHeaderTap,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Text(
                DateFormat.yMMMM(locale).format(monthDate),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isCurrentMonth ? const Color(0xFF4F46E5) : Colors.black87,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: weekdayLabels
                .map((label) => Expanded(
                      child: Center(
                        child: Text(
                          label,
                          style: TextStyle(fontSize: 12, color: Colors.grey.shade500, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 4),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1,
            ),
            itemCount: leadingBlanks + daysInMonth,
            itemBuilder: (context, index) {
              if (index < leadingBlanks) return const SizedBox.shrink();

              final day = index - leadingBlanks + 1;
              final date = DateTime(year, month, day);
              final isToday = now.year == year && now.month == month && now.day == day;
              final hasItems = itemCountForDate(date) > 0;

              return InkWell(
                onTap: () => onDayTap(date),
                customBorder: const CircleBorder(),
                child: Center(
                  child: Container(
                    width: 32,
                    height: 32,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isToday
                          ? const Color(0xFF4F46E5)
                          : hasItems
                              ? const Color(0xFF4F46E5).withValues(alpha: 0.15)
                              : null,
                    ),
                    child: Text(
                      '$day',
                      style: TextStyle(
                        fontSize: 14,
                        color: isToday
                            ? Colors.white
                            : hasItems
                                ? const Color(0xFF4F46E5)
                                : Colors.black87,
                        fontWeight: isToday || hasItems ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const Divider(height: 24),
        ],
      ),
    );
  }
}