import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/services/biometric_service.dart';

/// Holds device-level app preferences that aren't tied to the
/// signed-in user's account data — biometric app-lock, and now the
/// app's display language. Stored in shared_preferences so it
/// persists across restarts, and deliberately NOT scoped by uid:
/// these are "this device's copy of the app" settings, the same
/// way a phone's own lock screen or language isn't per-account either.
class SettingsProvider extends ChangeNotifier {
  static const _biometricEnabledKey = 'biometric_lock_enabled';
  static const _languageCodeKey = 'app_language_code';

  /// Languages the app ships translations for. `null` represents
  /// "System default" (follow the device's own language setting).
  static const List<Locale?> supportedLocales = [
    null,
    Locale('en'),
    Locale('fr'),
    Locale('es'),
    Locale('de'),
    Locale('ja'),
    Locale('zh'),
  ];

  final BiometricService _biometricService;

  bool _biometricEnabled = false;
  bool _isLoading = true;
  Locale? _locale;

  SettingsProvider({BiometricService? biometricService})
      : _biometricService = biometricService ?? BiometricService() {
    _loadPreference();
  }

  bool get biometricEnabled => _biometricEnabled;
  bool get isLoading => _isLoading;
  BiometricService get biometricService => _biometricService;

  /// The user's chosen locale, or null to follow the system language.
  /// Passed straight into `MaterialApp(locale: ...)`.
  Locale? get locale => _locale;

  Future<void> _loadPreference() async {
    final prefs = await SharedPreferences.getInstance();
    _biometricEnabled = prefs.getBool(_biometricEnabledKey) ?? false;
    final savedCode = prefs.getString(_languageCodeKey);
    _locale = (savedCode == null || savedCode.isEmpty) ? null : Locale(savedCode);
    _isLoading = false;
    notifyListeners();
  }

  /// Changes the app's display language immediately and persists the
  /// choice. Pass `null` to go back to following the device's own
  /// language setting.
  Future<void> setLocale(Locale? locale) async {
    _locale = locale;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    if (locale == null) {
      await prefs.remove(_languageCodeKey);
    } else {
      await prefs.setString(_languageCodeKey, locale.languageCode);
    }
  }

  /// Turns biometric lock ON. Requires a successful authentication
  /// first, both to confirm the device is actually capable and
  /// enrolled, and so the user isn't surprised by a lock screen they
  /// didn't expect to be able to pass.
  ///
  /// Returns an error message on failure (null on success), so the
  /// Settings screen can show exactly why it didn't turn on.
  Future<String?> enableBiometric() async {
    final supported = await _biometricService.isDeviceSupported();
    if (!supported) {
      return 'Biometric authentication is not available on this device.';
    }

    final enrolled = await _biometricService.hasEnrolledBiometrics();
    if (!enrolled) {
      return 'No fingerprint or face is set up on this device yet. '
          'Add one in your device settings first.';
    }

    final result = await _biometricService.authenticate(
      reason: 'Authenticate to enable biometric unlock',
    );
    if (!result.success) {
      return result.errorMessage ?? 'Authentication was cancelled.';
    }

    _biometricEnabled = true;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_biometricEnabledKey, true);
    return null;
  }

  /// Turns biometric lock OFF. No re-authentication required to
  /// disable, matching common apps (WhatsApp, banking apps etc. vary,
  /// but requiring auth to opt OUT of a security feature has limited
  /// benefit and mainly frustrates users who are switching devices).
  Future<void> disableBiometric() async {
    _biometricEnabled = false;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_biometricEnabledKey, false);
  }
}