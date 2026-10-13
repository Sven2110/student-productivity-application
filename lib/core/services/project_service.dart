import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/project_model.dart';
import '../../models/attachment_model.dart';

class ProjectService {
  CollectionReference _projectsRef(String uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('projects');
  }

  Stream<List<ProjectModel>> watchProjects(String uid) {
    return _projectsRef(uid).snapshots().map((snapshot) {
      final projects =
          snapshot.docs.map((doc) => ProjectModel.fromFirestore(doc)).toList();
      projects.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return projects;
    });
  }

  /// Reserves a Firestore document ID WITHOUT writing anything, so
  /// attachment files can be copied into attachments/projects/{id}/
  /// before the project is saved in a single write.
  String newId(String uid) => _projectsRef(uid).doc().id;

  /// Create-or-update in ONE write, including the attachments list
  /// (the project's [ProjectModel.id] must already be set — see
  /// [newId]). Offline-safe: see TaskService.saveTask for why the
  /// server acknowledgement is only awaited for a limited time.
  Future<void> saveProject(String uid, ProjectModel project) async {
    await _projectsRef(uid)
        .doc(project.id)
        .set(project.toFirestore(), SetOptions(merge: true))
        .timeout(_serverAckTimeout, onTimeout: () {});
  }

  static const Duration _serverAckTimeout = Duration(seconds: 8);

  Future<String> addProject(String uid, ProjectModel project) async {
    final docRef = await _projectsRef(uid).add(project.toFirestore());
    return docRef.id;
  }

  Future<void> updateProject(String uid, ProjectModel project) async {
    await _projectsRef(uid).doc(project.id).update(project.toFirestore());
  }

  Future<void> deleteProject(String uid, String projectId) async {
    await _projectsRef(uid).doc(projectId).delete();
  }

  Future<void> updateAttachments(
    String uid,
    String projectId,
    List<AttachmentModel> attachments,
  ) async {
    await _projectsRef(uid).doc(projectId).update({
      'attachments': attachments.map((a) => a.toMap()).toList(),
    });
  }
}