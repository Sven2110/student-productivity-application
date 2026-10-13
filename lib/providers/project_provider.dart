import 'dart:async';
import 'package:flutter/foundation.dart';
import '../core/services/project_service.dart';
import '../models/project_model.dart';
import '../models/attachment_model.dart';

class ProjectProvider extends ChangeNotifier {
  final ProjectService _service = ProjectService();

  StreamSubscription<List<ProjectModel>>? _subscription;
  List<ProjectModel> _projects = [];
  String? _currentUid;
  bool _isLoading = false;
  String? _errorMessage;

  List<ProjectModel> get projects => _projects;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  List<ProjectModel> projectsByStatus(ProjectStatus status) =>
      _projects.where((p) => p.status == status).toList();

  void updateAuthUid(String? uid) {
    if (uid == _currentUid) return;
    _currentUid = uid;
    _subscription?.cancel();

    if (uid == null) {
      _projects = [];
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    _subscription = _service.watchProjects(uid).listen(
      (projects) {
        _projects = projects;
        _isLoading = false;
        notifyListeners();
      },
      onError: (error) {
        _errorMessage = 'Failed to load projects: $error';
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  /// Reserves a new project ID (no write happens). Returns null if no
  /// user is signed in.
  String? generateProjectId() {
    if (_currentUid == null) return null;
    return _service.newId(_currentUid!);
  }

  /// THE save method used by the project form. Creates or updates the
  /// project AND its attachment list in a single Firestore write.
  /// [project.id] must already be set (use [generateProjectId] for
  /// new projects). Returns true only if the project was saved.
  Future<bool> saveProject(ProjectModel project) async {
    if (_currentUid == null) {
      _errorMessage = 'Not signed in — cannot save project.';
      notifyListeners();
      return false;
    }
    _errorMessage = null;
    try {
      await _service.saveProject(_currentUid!, project);
      return true;
    } catch (e) {
      _errorMessage = 'Failed to save project: $e';
      notifyListeners();
      return false;
    }
  }

  /// Returns the new project's ID on success, or null on failure.
  Future<String?> addProject(ProjectModel project) async {
    if (_currentUid == null) return null;
    try {
      return await _service.addProject(_currentUid!, project);
    } catch (e) {
      _errorMessage = 'Failed to add project: $e';
      notifyListeners();
      return null;
    }
  }

  Future<bool> updateProject(ProjectModel project) async {
    if (_currentUid == null) return false;
    try {
      await _service.updateProject(_currentUid!, project);
      return true;
    } catch (e) {
      _errorMessage = 'Failed to update project: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteProject(String projectId) async {
    if (_currentUid == null) return false;
    try {
      await _service.deleteProject(_currentUid!, projectId);
      return true;
    } catch (e) {
      _errorMessage = 'Failed to delete project: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> persistAttachments(String projectId, List<AttachmentModel> attachments) async {
    if (_currentUid == null) return false;
    try {
      await _service.updateAttachments(_currentUid!, projectId, attachments);
      return true;
    } catch (e) {
      _errorMessage = 'Failed to update attachments: $e';
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