import 'package:local_auth/local_auth.dart';

/// Result of a single authentication attempt. Carrying a friendly
/// [errorMessage] alongside [success] means callers can show it
/// directly in a SnackBar without knowing about LocalAuthException
/// error codes.
class BiometricAuthResult {
  final bool success;
  final String? errorMessage;

  const BiometricAuthResult.success()
      : success = true,
        errorMessage = null;

  const BiometricAuthResult.failure(this.errorMessage)
      : success = false;
}

/// Wraps the local_auth plugin so the rest of the app never has to
/// deal with LocalAuthException directly. Used for the optional
/// app-lock feature (Settings > Biometric Unlock).
class BiometricService {
  final LocalAuthentication _auth = LocalAuthentication();

  /// True if the device has biometric hardware OR some other
  /// device-level lock (PIN/pattern/passcode) that could be used
  /// as a fallback.
  Future<bool> isDeviceSupported() async {
    try {
      final canCheckBiometrics = await _auth.canCheckBiometrics;
      final deviceSupported = await _auth.isDeviceSupported();

      return canCheckBiometrics || deviceSupported;
    } catch (_) {
      return false;
    }
  }

  /// True only if the user has actually enrolled a fingerprint/face
  /// on this device.
  Future<bool> hasEnrolledBiometrics() async {
    try {
      final available = await _auth.getAvailableBiometrics();

      return available.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  /// Prompts the OS-native biometric dialog.
  ///
  /// biometricOnly: false means the user can use biometrics or
  /// the device PIN/pattern/password as a fallback.
  Future<BiometricAuthResult> authenticate({
    String reason = 'Authenticate to unlock the app',
  }) async {
    try {
      final didAuthenticate = await _auth.authenticate(
        localizedReason: reason,
        biometricOnly: false,
        persistAcrossBackgrounding: true,
      );

      return didAuthenticate
          ? const BiometricAuthResult.success()
          : const BiometricAuthResult.failure(null);
    } on LocalAuthException catch (e) {
      return BiometricAuthResult.failure(_messageFor(e));
    } catch (_) {
      return const BiometricAuthResult.failure(
        'Something went wrong while authenticating. Please try again.',
      );
    }
  }

  String _messageFor(LocalAuthException e) {
    switch (e.code) {
      case LocalAuthExceptionCode.noBiometricHardware:
        return 'This device has no biometric hardware.';

      case LocalAuthExceptionCode.noBiometricsEnrolled:
        return 'No fingerprint or face is set up on this device yet. '
            'Add one in your device settings first.';

      case LocalAuthExceptionCode.temporaryLockout:
        return 'Too many attempts. Please try again in a moment.';

      case LocalAuthExceptionCode.biometricLockout:
        return 'Biometric authentication is locked. Use your device '
            'passcode instead.';

      case LocalAuthExceptionCode.noCredentialsSet:
        return 'Set up a device passcode/PIN to use this feature.';

      case LocalAuthExceptionCode.userCanceled:
        return 'Authentication was cancelled.';

      default:
        return 'Authentication failed. Error code: ${e.code}';
    }
  }
}