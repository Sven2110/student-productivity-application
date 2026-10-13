import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/module_progress_model.dart';

/// Named ProgressTrackingService (not ProgressService) to avoid any
/// confusion with the existing StudentProfileModel's "profile" naming
/// and to be explicit this is specifically syllabus/module tracking.
class ProgressTrackingService {
  CollectionReference _progressRef(String uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('progress');
  }

  Stream<List<ModuleProgressModel>> watchProgress(String uid) {
    return _progressRef(uid).snapshots().map((snapshot) {
      final items =
          snapshot.docs.map((doc) => ModuleProgressModel.fromFirestore(doc)).toList();
      items.sort((a, b) => a.subject.compareTo(b.subject));
      return items;
    });
  }

  Future<void> addModule(String uid, ModuleProgressModel module) async {
    await _progressRef(uid).add(module.toFirestore());
  }

  Future<void> updateModule(String uid, ModuleProgressModel module) async {
    await _progressRef(uid).doc(module.id).update(module.toFirestore());
  }

  Future<void> deleteModule(String uid, String moduleId) async {
    await _progressRef(uid).doc(moduleId).delete();
  }
}