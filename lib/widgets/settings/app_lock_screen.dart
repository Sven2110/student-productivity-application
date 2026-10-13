import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

/// Full-screen lock shown in front of the app when biometric unlock
/// is enabled and the app is (re)opened. Mirrors a phone's own lock
/// screen: an icon, a short message, and a button to trigger the
/// OS biometric prompt again if the user dismissed it or it failed.
class AppLockScreen extends StatelessWidget {
  final VoidCallback onUnlockPressed;
  final bool isAuthenticating;
  final String? errorMessage;

  const AppLockScreen({
    super.key,
    required this.onUnlockPressed,
    this.isAuthenticating = false,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  color: const Color(0xFF4F46E5).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.fingerprint,
                  size: 48,
                  color: Color(0xFF4F46E5),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                l10n.appLockedTitle,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.appLockedSubtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
              if (errorMessage != null) ...[
                const SizedBox(height: 16),
                Text(
                  errorMessage!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red, fontSize: 13),
                ),
              ],
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: isAuthenticating ? null : onUnlockPressed,
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF4F46E5),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: isAuthenticating
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.fingerprint),
                  label: Text(isAuthenticating ? l10n.appLockAuthenticating : l10n.appLockUnlockButton),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}