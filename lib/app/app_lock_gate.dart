import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../providers/settings_provider.dart';
import '../widgets/settings/app_lock_screen.dart';

/// Sits in front of the authenticated part of the app and handles biometric locking.
/// When biometric unlock is enabled in Settings, it: 
/// - locks the app on startup, 
/// - locks it again whenever it moves to the background, such as when
/// - switching apps or receiving a phone call, just like a phone's lock screen, 
/// - displays [AppLockScreen] and triggers the system biometric prompt 
/// until authentication succeeds. 
/// When biometric unlock is disabled, it simply passes through to [child] without doing anything.
class AppLockGate extends StatefulWidget {
  final Widget child;

  const AppLockGate({super.key, required this.child});

  @override
  State<AppLockGate> createState() => _AppLockGateState();
}

class _AppLockGateState extends State<AppLockGate> with WidgetsBindingObserver {
  bool _isUnlocked = false;
  bool _isAuthenticating = false;
  String? _errorMessage;

  // Tracks whether we've ever successfully unlocked this session, so
  // we don't immediately re-lock ourselves mid cold-start before the
  // first prompt has even had a chance to run.
  bool _hasUnlockedOnce = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final settings = context.read<SettingsProvider>();
    if (!settings.biometricEnabled) return;

    if (state == AppLifecycleState.paused && _hasUnlockedOnce) {
      // Re-lock so the next resume requires another prompt.
      setState(() {
        _isUnlocked = false;
        _errorMessage = null;
      });
    } else if (state == AppLifecycleState.resumed && !_isUnlocked) {
      _promptUnlock();
    }
  }

  Future<void> _promptUnlock() async {
    if (_isAuthenticating) return;
    setState(() {
      _isAuthenticating = true;
      _errorMessage = null;
    });

    final settings = context.read<SettingsProvider>();
    final l10n = AppLocalizations.of(context)!;
    final result = await settings.biometricService.authenticate(
      reason: l10n.appLockAuthReason(l10n.appTitle),
    );

    if (!mounted) return;
    setState(() {
      _isAuthenticating = false;
      if (result.success) {
        _isUnlocked = true;
        _hasUnlockedOnce = true;
        _errorMessage = null;
      } else {
        _errorMessage = result.errorMessage;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();

    // Setting still loading from disk, or feature disabled: don't
    // gate anything.
    if (settings.isLoading || !settings.biometricEnabled) {
      return widget.child;
    }

    if (!_isUnlocked) {
      // Kick off the very first prompt automatically once, right
      // after this frame renders, rather than waiting for a resume
      // event (there isn't one on cold start).
      if (!_hasUnlockedOnce && !_isAuthenticating && _errorMessage == null) {
        WidgetsBinding.instance.addPostFrameCallback((_) => _promptUnlock());
      }
      return AppLockScreen(
        onUnlockPressed: _promptUnlock,
        isAuthenticating: _isAuthenticating,
        errorMessage: _errorMessage,
      );
    }

    return widget.child;
  }
}