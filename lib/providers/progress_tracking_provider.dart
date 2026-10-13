import 'dart:async';
import 'package:flutter/foundation.dart';
import '../core/services/progress_tracking_service.dart';
import '../models/module_progress_model.dart';

class ProgressTrackingProvider extends ChangeNotifier {
  final ProgressTrackingService _service = ProgressTrackingService();

  StreamSubscription<List<ModuleProgressModel>>? _subscription;
  List<ModuleProgressModel> _modules = [];
  String? _currentUid;
  bool _isLoading = false;
  String? _errorMessage;

  List<ModuleProgressModel> get modules => _modules;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Average progress percentage across every tracked subject —
  /// used for the Dashboard's "Progress" stat card.
  double get averagePercentage {
    if (_modules.isEmpty) return 0.0;
    final total = _modules.fold<double>(0, (sum, m) => sum + m.percentage);
    return total / _modules.length;
  }

  void updateAuthUid(String? uid) {
    if (uid == _currentUid) return;
    _currentUid = uid;

    _subscription?.cancel();

    if (uid == null) {
      _modules = [];
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    _subscription = _service.watchProgress(uid).listen(
      (modules) {
        _modules = modules;
        _isLoading = false;
        notifyListeners();
      },
      onError: (error) {
        _errorMessage = 'Failed to load progress: $error';
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<bool> addModule(ModuleProgressModel module) async {
    if (_currentUid == null) return false;
    try {
      await _service.addModule(_currentUid!, module);
      return true;
    } catch (e) {
      _errorMessage = 'Failed to add module: $e';
      notifyListeners();
      return false;
    }
  }

  /// Called directly by the +/- stepper controls on the Progress
  /// screen — clamped so completedTopics can never go negative or
  /// exceed totalTopics.
  Future<void> adjustCompletedTopics(ModuleProgressModel module, int delta) async {
    if (_currentUid == null) return;
    final newCompleted = (module.completedTopics + delta).clamp(0, module.totalTopics);
    final updated = module.copyWith(completedTopics: newCompleted);

    // Optimistic local update for instant visual feedback.
    final index = _modules.indexWhere((m) => m.id == module.id);
    if (index != -1) {
      _modules[index] = updated;
      notifyListeners();
    }

    await _service.updateModule(_currentUid!, updated);
  }

  Future<bool> updateModule(ModuleProgressModel module) async {
    if (_currentUid == null) return false;
    try {
      await _service.updateModule(_currentUid!, module);
      return true;
    } catch (e) {
      _errorMessage = 'Failed to update module: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteModule(String moduleId) async {
    if (_currentUid == null) return false;
    try {
      await _service.deleteModule(_currentUid!, moduleId);
      return true;
    } catch (e) {
      _errorMessage = 'Failed to delete module: $e';
      notifyListeners();
      return false;
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}