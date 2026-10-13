import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../l10n/app_localizations.dart';
import '../../models/project_model.dart';

class ProjectCard extends StatelessWidget {
  final ProjectModel project;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const ProjectCard({
    super.key,
    required this.project,
    required this.onTap,
    required this.onDelete,
  });

  Color get _statusColor {
    switch (project.status) {
      case ProjectStatus.ongoing:
        return const Color(0xFF4F46E5);
      case ProjectStatus.pending:
        return const Color(0xFFEA580C);
      case ProjectStatus.completed:
        return const Color(0xFF16A34A);
      case ProjectStatus.cancelled:
        return const Color(0xFF6B7280);
    }
  }

  bool get _isOverdue =>
      project.status != ProjectStatus.completed &&
      project.status != ProjectStatus.cancelled &&
      project.dueDate != null &&
      project.dueDate!.isBefore(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final dateFormat = DateFormat.yMd(Localizations.localeOf(context).toString());

    return Dismissible(
      key: ValueKey(project.id),
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
            title: Text(l10n.projectDeleteTitle),
            content: Text(l10n.projectDeleteBody(project.title)),
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
        margin: const EdgeInsets.only(bottom: 12),
        color: Colors.grey.shade50,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        project.title,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: _statusColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        project.status.label(l10n),
                        style: TextStyle(fontSize: 11, color: _statusColor, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                if (project.description.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    project.description,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                const SizedBox(height: 8),
                Row(
                  children: [
                    if (project.dueDate != null) ...[
                      Icon(Icons.calendar_today_outlined,
                          size: 13, color: _isOverdue ? Colors.red : Colors.grey.shade600),
                      const SizedBox(width: 4),
                      Text(
                        l10n.projectDue(dateFormat.format(project.dueDate!)),
                        style: TextStyle(
                          fontSize: 12,
                          color: _isOverdue ? Colors.red : Colors.grey.shade600,
                          fontWeight: _isOverdue ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                    if (project.attachments.isNotEmpty) ...[
                      const SizedBox(width: 10),
                      const Icon(Icons.attach_file, size: 13, color: Colors.grey),
                      Text('${project.attachments.length}',
                          style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}