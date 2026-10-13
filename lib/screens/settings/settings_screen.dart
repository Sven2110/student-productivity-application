import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/auth_provider.dart';
import '../../providers/settings_provider.dart';

/// Settings gets a real logout button now (it's simple and needed
/// for testing), but the full settings UI comes in Phase 18.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _biometricBusy = false;

  Future<void> _onBiometricToggled(bool wantsEnabled) async {
    final settings = context.read<SettingsProvider>();
    final l10n = AppLocalizations.of(context)!;
    setState(() => _biometricBusy = true);

    if (wantsEnabled) {
      final error = await settings.enableBiometric();
      if (!mounted) return;
      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_localizedBiometricError(l10n, error))),
        );
      }
    } else {
      await settings.disableBiometric();
    }

    if (!mounted) return;
    setState(() => _biometricBusy = false);
  }

  /// SettingsProvider currently returns raw English error strings from
  /// the biometric service (device capability messages). We map the
  /// handful we recognize to localized copy, and fall back to showing
  /// the original message for anything unexpected (e.g. a
  /// platform-specific error) rather than hiding it.
  String _localizedBiometricError(AppLocalizations l10n, String error) {
    switch (error) {
      case 'Biometric authentication is not available on this device.':
        return l10n.biometricNotAvailable;
      case 'No fingerprint or face is set up on this device yet. '
          'Add one in your device settings first.':
        return l10n.biometricNotEnrolled;
      case 'Authentication was cancelled.':
        return l10n.biometricAuthCancelled;
      default:
        return error;
    }
  }

  String _languageLabel(AppLocalizations l10n, Locale? locale) {
    switch (locale?.languageCode) {
      case 'en':
        return l10n.languageEnglish;
      case 'fr':
        return l10n.languageFrench;
      case 'es':
        return l10n.languageSpanish;
      case 'de':
        return l10n.languageGerman;
      case 'ja':
        return l10n.languageJapanese;
      case 'zh':
        return l10n.languageChinese;
      default:
        return l10n.languageSystemDefault;
    }
  }

  Future<void> _showLanguagePicker() async {
    final settings = context.read<SettingsProvider>();
    final l10n = AppLocalizations.of(context)!;

    final chosen = await showModalBottomSheet<Object?>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Text(
                l10n.settingsChooseLanguage,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            for (final locale in SettingsProvider.supportedLocales)
              RadioListTile<Locale?>(
                // Wrapping in `Locale?` explicitly keeps `null` (system
                // default) working the same as a real locale value.
                value: locale,
                groupValue: settings.locale,
                title: Text(_languageLabel(l10n, locale)),
                onChanged: (value) => Navigator.pop(ctx, value ?? const _NullLocale()),
              ),
          ],
        ),
      ),
    );

    if (chosen == null) return; // sheet dismissed without a selection
    final newLocale = chosen is _NullLocale ? null : chosen as Locale;
    await settings.setLocale(newLocale);
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final settingsProvider = context.watch<SettingsProvider>();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: Text(authProvider.user?.email ?? l10n.unknownUser),
            subtitle: Text(l10n.settingsSignedIn),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                l10n.settingsSecuritySection,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.fingerprint, color: Color(0xFF4F46E5)),
            title: Text(l10n.settingsBiometricUnlock),
            subtitle: Text(l10n.settingsBiometricUnlockSubtitle),
            value: settingsProvider.biometricEnabled,
            onChanged: (settingsProvider.isLoading || _biometricBusy)
                ? null
                : _onBiometricToggled,
          ),
          if (_biometricBusy)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                l10n.settingsLanguageSection,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.language, color: Color(0xFF4F46E5)),
            title: Text(l10n.settingsLanguage),
            subtitle: Text(_languageLabel(l10n, settingsProvider.locale)),
            trailing: const Icon(Icons.chevron_right),
            onTap: _showLanguagePicker,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: Text(l10n.settingsLogout, style: const TextStyle(color: Colors.red)),
            onTap: () => authProvider.logout(),
          ),
        ],
      ),
    );
  }
}

/// Sentinel used so the language bottom sheet can distinguish "user
/// picked System default (null)" from "user dismissed without picking"
/// when both would otherwise just be `null` coming back from `pop()`.
class _NullLocale {
  const _NullLocale();
}