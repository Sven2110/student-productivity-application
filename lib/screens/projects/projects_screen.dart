import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/project_provider.dart';
import '../../models/project_model.dart';
import '../../widgets/projects/project_card.dart';
import '../../widgets/projects/project_form.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  static const _statusOrder = [
    ProjectStatus.ongoing,
    ProjectStatus.pending,
    ProjectStatus.completed,
    ProjectStatus.cancelled,
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _statusOrder.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _openForm(BuildContext context, {ProjectModel? existingProject}) async {
    final currentStatus = _statusOrder[_tabController.index];

    // The form saves the project (and its attachments) itself and
    // shows its own error feedback. It pops with the already-saved
    // project only so we can jump to that project's status tab.
    final saved = await showModalBottomSheet<ProjectModel>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => ProjectForm(
        existingProject: existingProject,
        initialStatus: currentStatus,
      ),
    );

    if (saved == null || !mounted) return;
    setState(() => _tabController.index = _statusOrder.indexOf(saved.status));
  }

  @override
  Widget build(BuildContext context) {
    final projectProvider = context.watch<ProjectProvider>();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.projectsTitle),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: _statusOrder
              .map((status) => Tab(
                    text: '${status.label(l10n)} (${projectProvider.projectsByStatus(status).length})',
                  ))
              .toList(),
        ),
      ),
      body: projectProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: _statusOrder.map((status) {
                final projects = projectProvider.projectsByStatus(status);

                if (projects.isEmpty) {
                  return Center(
                    child: Text(l10n.projectEmpty, style: const TextStyle(color: Colors.grey)),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: projects.length,
                  itemBuilder: (context, i) {
                    final project = projects[i];
                    return ProjectCard(
                      project: project,
                      onTap: () => _openForm(context, existingProject: project),
                      onDelete: () => context.read<ProjectProvider>().deleteProject(project.id),
                    );
                  },
                );
              }).toList(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}