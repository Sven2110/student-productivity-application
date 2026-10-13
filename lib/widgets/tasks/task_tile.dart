import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../l10n/app_localizations.dart';
import '../../models/task_model.dart';

class TaskTile extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onToggle;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const TaskTile({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onTap,
    required this.onDelete,
  });

  Color get _priorityColor {
    switch (task.priority) {
      case TaskPriority.high:
        return const Color(0xFFDC2626);
      case TaskPriority.medium:
        return const Color(0xFFEA580C);
      case TaskPriority.low:
        return const Color(0xFF16A34A);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // Locale-aware short date (e.g. "9/17/26" in en, "17/9/26" in fr,
    // "2026/9/17" in zh) instead of a single hardcoded d/M/y format.
    final dateFormat = DateFormat.yMd(Localizations.localeOf(context).toString());

    return Dismissible(
      key: ValueKey(task.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (_) async {
        return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(l10n.taskDeleteTitle),
            content: Text(l10n.taskDeleteBody(task.title)),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l10n.cancel)),
              TextButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: Text(l10n.delete, style: const TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ) ?? false;
      },
      onDismissed: (_) => onDelete(),
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.only(bottom: 10),
        color: Colors.grey.shade50,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: ListTile(
          onTap: onTap,
          leading: Checkbox(
            value: task.isCompleted,
            onChanged: (_) => onToggle(),
            shape: const CircleBorder(),
          ),
          title: Text(
            task.title,
            style: TextStyle(
              decoration: task.isCompleted ? TextDecoration.lineThrough : null,
              color: task.isCompleted ? Colors.grey : Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: task.dueDate != null
              ? Text(
                  l10n.taskDue(dateFormat.format(task.dueDate!)),
                  style: TextStyle(
                    color: task.isOverdue ? Colors.red : Colors.grey.shade600,
                    fontWeight: task.isOverdue ? FontWeight.bold : FontWeight.normal,
                  ),
                )
              : null,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (task.attachments.isNotEmpty) ...[
                const Icon(Icons.attach_file, size: 14, color: Colors.grey),
                Text('${task.attachments.length}',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
                const SizedBox(width: 8),
              ],
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(color: _priorityColor, shape: BoxShape.circle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}