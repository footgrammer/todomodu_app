import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/subtask.dart';
import '../../domain/repositories/subtask_repository.dart';

class SubtaskRepositoryImpl implements SubtaskRepository {
  final FirebaseFirestore firestore;

  SubtaskRepositoryImpl(this.firestore);

  @override
  Stream<List<Subtask>> streamSubtasks(String projectId, String todoId) {
    return firestore
        .collection('projects')
        .doc(projectId)
        .collection('subtasks')
        .where('todoId', isEqualTo: todoId)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Subtask.fromMap(doc.data())).toList());
  }

  @override
  Future<void> createSubtask(Subtask subtask) async {
    final docRef = firestore
        .collection('projects')
        .doc(subtask.projectId)
        .collection('subtasks')
        .doc(subtask.id);

    await docRef.set(subtask.toMap());
  }

  @override
  Future<void> deleteSubtask({
    required String projectId,
    required String subtaskId,
  }) async {
    await firestore
        .collection('projects')
        .doc(projectId)
        .collection('subtasks')
        .doc(subtaskId)
        .delete();
  }

  @override
  Future<void> updateSubtask(Subtask subtask) async {
    await firestore
        .collection('projects')
        .doc(subtask.projectId)
        .collection('subtasks')
        .doc(subtask.id)
        .update(subtask.toMap());
  }

  @override
  Future<void> toggleDone({
    required String projectId,
    required String subtaskId,
    required bool isDone,
  }) async {
    await firestore
        .collection('projects')
        .doc(projectId)
        .collection('subtasks')
        .doc(subtaskId)
        .update({'isDone': isDone});
  }
}
