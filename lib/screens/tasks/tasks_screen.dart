import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/task_provider.dart';
import '../../models/task_model.dart';
import '../../widgets/tasks/task_tile.dart';
import '../../widgets/tasks/task_form.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  /// The form saves the task (and its attachments) itself and shows
  /// its own success/error feedback, so there is nothing left to do
  /// here once the sheet closes — the task list updates live from
  /// the Firestore stream in TaskProvider.
  Future<void> _openForm(BuildContext context, {TaskModel? existingTask}) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => TaskForm(existingTask: existingTask),
    );
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();
    final pending = taskProvider.pendingTasks;
    final completed = taskProvider.completedTasks;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.tasksTitle)),
      body: taskProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : (pending.isEmpty && completed.isEmpty)
              ? Center(
                  child: Text(l10n.tasksEmpty, style: const TextStyle(color: Colors.grey)),
                )
              : ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    if (pending.isNotEmpty) ...[
                      Text(l10n.tasksPendingCount(pending.length),
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 10),
                      ...pending.map((task) => TaskTile(
                            task: task,
                            onToggle: () => context.read<TaskProvider>().toggleComplete(task),
                            onTap: () => _openForm(context, existingTask: task),
                            onDelete: () => context.read<TaskProvider>().deleteTask(task.id),
                          )),
                      const SizedBox(height: 20),
                    ],
                    if (completed.isNotEmpty) ...[
                      Text(l10n.tasksCompletedCount(completed.length),
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey.shade600)),
                      const SizedBox(height: 10),
                      ...completed.map((task) => TaskTile(
                            task: task,
                            onToggle: () => context.read<TaskProvider>().toggleComplete(task),
                            onTap: () => _openForm(context, existingTask: task),
                            onDelete: () => context.read<TaskProvider>().deleteTask(task.id),
                          )),
                    ],
                  ],
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}