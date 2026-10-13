import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../providers/auth_provider.dart';
import '../providers/profile_provider.dart';
import '../providers/navigation_provider.dart';
import '../providers/settings_provider.dart';
import '../providers/timetable_provider.dart';
import '../providers/task_provider.dart';
import '../providers/note_provider.dart';
import '../providers/progress_tracking_provider.dart';
import '../providers/project_provider.dart';
import '../providers/calendar_event_provider.dart';
import '../screens/auth/login_screen.dart';
import '../screens/main_shell/main_shell_screen.dart';
import 'app_lock_gate.dart';
import 'app_router.dart';
import 'app_theme.dart';

class StudentProductivityApp extends StatelessWidget {
  const StudentProductivityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),

        ChangeNotifierProxyProvider<AuthProvider, ProfileProvider>(
          create: (_) => ProfileProvider(),
          update: (_, authProvider, profileProvider) {
            final provider = profileProvider ?? ProfileProvider();
            provider.updateAuthUid(authProvider.user?.uid);
            return provider;
          },
        ),

        ChangeNotifierProxyProvider<AuthProvider, TimetableProvider>(
          create: (_) => TimetableProvider(),
          update: (_, authProvider, timetableProvider) {
            final provider = timetableProvider ?? TimetableProvider();
            provider.updateAuthUid(authProvider.user?.uid);
            return provider;
          },
        ),

        ChangeNotifierProxyProvider<AuthProvider, TaskProvider>(
          create: (_) => TaskProvider(),
          update: (_, authProvider, taskProvider) {
            final provider = taskProvider ?? TaskProvider();
            provider.updateAuthUid(authProvider.user?.uid);
            return provider;
          },
        ),

        ChangeNotifierProxyProvider<AuthProvider, NoteProvider>(
          create: (_) => NoteProvider(),
          update: (_, authProvider, noteProvider) {
            final provider = noteProvider ?? NoteProvider();
            provider.updateAuthUid(authProvider.user?.uid);
            return provider;
          },
        ),

        ChangeNotifierProxyProvider<AuthProvider, ProgressTrackingProvider>(
          create: (_) => ProgressTrackingProvider(),
          update: (_, authProvider, progressProvider) {
            final provider = progressProvider ?? ProgressTrackingProvider();
            provider.updateAuthUid(authProvider.user?.uid);
            return provider;
          },
        ),

        ChangeNotifierProxyProvider<AuthProvider, ProjectProvider>(
          create: (_) => ProjectProvider(),
          update: (_, authProvider, projectProvider) {
            final provider = projectProvider ?? ProjectProvider();
            provider.updateAuthUid(authProvider.user?.uid);
            return provider;
          },
        ),

        ChangeNotifierProxyProvider<AuthProvider, CalendarEventProvider>(
          create: (_) => CalendarEventProvider(),
          update: (_, authProvider, eventProvider) {
            final provider = eventProvider ?? CalendarEventProvider();
            provider.updateAuthUid(authProvider.user?.uid);
            return provider;
          },
        ),

        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, settings, _) {
          return MaterialApp(
            title: 'Student Productivity',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            onGenerateRoute: AppRouter.generateRoute,
            // `null` here means "follow the device's language", which
            // Flutter resolves via `localeResolutionCallback` below.
            locale: settings.locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            // If the device language isn't supported, default to English
            // to avoid errors or displaying incorrect translations.
            localeResolutionCallback: (deviceLocale, supported) {
              if (deviceLocale != null &&
                  supported.any((l) => l.languageCode == deviceLocale.languageCode)) {
                return deviceLocale;
              }
              return const Locale('en');
            },
            home: const _AuthGate(),
          );
        },
      ),
    );
  }
}

class _AuthGate extends StatelessWidget {
  const _AuthGate();

  @override
  Widget build(BuildContext context) {
    final status = context.watch<AuthProvider>().status;

    switch (status) {
      case AuthStatus.uninitialized:
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      case AuthStatus.authenticated:
        return const AppLockGate(child: MainShellScreen());
      case AuthStatus.unauthenticated:
        return const LoginScreen();
    }
  }
}