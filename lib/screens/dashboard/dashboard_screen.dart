import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/auth_provider.dart';
import '../../providers/profile_provider.dart';
import '../../providers/navigation_provider.dart';
import '../../providers/task_provider.dart';
import '../../providers/progress_tracking_provider.dart';
import '../../widgets/dashboard/quick_access_card.dart';
import '../../app/app_router.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final profileProvider = context.watch<ProfileProvider>();
    final taskProvider = context.watch<TaskProvider>();
    final progressProvider = context.watch<ProgressTrackingProvider>();
    final profile = profileProvider.profile;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.dashboardTitle)),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 400));
          },
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // ── Profile summary card ──
              if (profileProvider.isLoading)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(child: CircularProgressIndicator()),
                )
              else
                Card(
                  elevation: 0,
                  color: const Color(0xFFEEF0FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Builder(
                          builder: (context) {
                            final hasSavedPhoto = profile?.profileImagePath != null &&
                                profile!.profileImagePath!.isNotEmpty &&
                                File(profile.profileImagePath!).existsSync();
                            return CircleAvatar(
                              radius: 28,
                              backgroundColor: const Color(0xFF4F46E5),
                              backgroundImage:
                                  hasSavedPhoto ? FileImage(File(profile!.profileImagePath!)) : null,
                              child: !hasSavedPhoto
                                  ? Text(
                                      (profile?.email.isNotEmpty ?? false)
                                          ? profile!.email[0].toUpperCase()
                                          : '?',
                                      style: const TextStyle(fontSize: 22, color: Colors.white),
                                    )
                                  : null,
                            );
                          },
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (profile?.fullName.isNotEmpty ?? false)
                                    ? profile!.fullName
                                    : l10n.dashboardWelcome,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                authProvider.user?.email ?? '',
                                style: const TextStyle(color: Colors.grey),
                              ),
                              if (profile?.course.isNotEmpty ?? false)
                                Text(
                                  l10n.dashboardCourseYear(profile!.course, profile.yearOfStudy),
                                  style: const TextStyle(fontSize: 13),
                                ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit_outlined),
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.profile);
                          },
                        ),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 24),

              // ── Quick stats row ──
              // Now just 2 tiles: Tasks Due and Progress.
              Text(
                l10n.dashboardOverview,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _StatPlaceholder(
                      label: l10n.dashboardTasksDue,
                      value: '${taskProvider.pendingCount}',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatPlaceholder(
                      label: l10n.dashboardProgress,
                      value: progressProvider.modules.isEmpty
                          ? '—'
                          : '${progressProvider.averagePercentage.toStringAsFixed(0)}%',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // ── Quick access grid ──
              // 5 items: Calendar, Tasks, Notes, Progress, Projects.
              // Laid out as a row of 3 then a row of 2, each row
              // stretching to fill the full width, so there's never a
              // dangling empty cell.
              Text(
                l10n.dashboardQuickAccess,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: QuickAccessCard(
                      icon: Icons.calendar_month,
                      label: l10n.navCalendar,
                      color: const Color(0xFF4F46E5),
                      onTap: () => context.read<NavigationProvider>().setTab(1),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: QuickAccessCard(
                      icon: Icons.task_alt,
                      label: l10n.navTasks,
                      color: const Color(0xFF16A34A),
                      onTap: () => context.read<NavigationProvider>().setTab(2),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: QuickAccessCard(
                      icon: Icons.note_alt_outlined,
                      label: l10n.dashboardNotes,
                      color: const Color(0xFF0891B2),
                      onTap: () => Navigator.pushNamed(context, AppRoutes.notes),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: QuickAccessCard(
                      icon: Icons.trending_up,
                      label: l10n.dashboardProgress,
                      color: const Color(0xFF9333EA),
                      onTap: () => Navigator.pushNamed(context, AppRoutes.progress),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: QuickAccessCard(
                      icon: Icons.folder,
                      label: l10n.navProjects,
                      color: const Color(0xFFD97706),
                      onTap: () => context.read<NavigationProvider>().setTab(3),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatPlaceholder extends StatelessWidget {
  final String label;
  final String value;

  const _StatPlaceholder({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}