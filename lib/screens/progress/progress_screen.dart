import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/progress_tracking_provider.dart';
import '../../providers/task_provider.dart';
import '../../providers/timetable_provider.dart';
import '../../models/module_progress_model.dart';
import '../../widgets/progress/module_progress_card.dart';
import '../../widgets/progress/module_progress_form.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  List<String> _allSubjects(BuildContext context) {
    final timetableSubjects =
        context.read<TimetableProvider>().entries.map((e) => e.subject).toSet();
    final trackedSubjects =
        context.read<ProgressTrackingProvider>().modules.map((m) => m.subject).toSet();
    final combined = {...timetableSubjects}.difference(trackedSubjects).toList();
    combined.sort();
    return combined;
  }

  Future<void> _openForm(BuildContext context) async {
    final subjects = _allSubjects(context);

    final result = await showModalBottomSheet<ModuleProgressModel>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => ModuleProgressForm(availableSubjects: subjects),
    );

    if (result == null || !context.mounted) return;

    final provider = context.read<ProgressTrackingProvider>();
    final success = await provider.addModule(result);

    if (!success && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(provider.errorMessage ?? 'Something went wrong')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final progressProvider = context.watch<ProgressTrackingProvider>();
    final taskProvider = context.watch<TaskProvider>();

    final totalTasks = taskProvider.tasks.length;
    final completedTasks = taskProvider.completedTasks.length;
    final taskCompletionRate = totalTasks == 0 ? 0.0 : (completedTasks / totalTasks) * 100;

    return Scaffold(
      appBar: AppBar(title: const Text('Academic Progress')),
      body: progressProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // ── Consolidated overview ──
                const Text('Overview', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _OverviewTile(
                        label: 'Syllabus\nProgress',
                        percentage: progressProvider.averagePercentage,
                        color: const Color(0xFF9333EA),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _OverviewTile(
                        label: 'Task\nCompletion',
                        percentage: taskCompletionRate,
                        color: const Color(0xFF16A34A),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),
                const Text('Syllabus Coverage by Subject',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),

                if (progressProvider.modules.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: Center(
                      child: Text(
                        'No subjects tracked yet — tap + to start tracking',
                        style: TextStyle(color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                else
                  ...progressProvider.modules.map((module) => ModuleProgressCard(
                        module: module,
                        onIncrement: () =>
                            context.read<ProgressTrackingProvider>().adjustCompletedTopics(module, 1),
                        onDecrement: () =>
                            context.read<ProgressTrackingProvider>().adjustCompletedTopics(module, -1),
                        onDelete: () =>
                            context.read<ProgressTrackingProvider>().deleteModule(module.id),
                      )),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _OverviewTile extends StatelessWidget {
  final String label;
  final double percentage;
  final Color color;

  const _OverviewTile({required this.label, required this.percentage, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(
            '${percentage.toStringAsFixed(0)}%',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}