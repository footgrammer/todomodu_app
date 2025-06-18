import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/subtask.dart';
import '../../domain/repositories/subtask_repository.dart';

class SubtaskRepositoryImpl implements SubtaskRepository {
  final FirebaseFirestore firestore;

  SubtaskRepositoryImpl({required this.firestore});

  @override
  Future<void> createSubtask(Subtask subtask) async {
    await firestore
        .collection('projects')
        .doc(subtask.projectId)
        .collection('subtasks')
        .doc(subtask.id)
        .set(subtask.toMap());
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
  Stream<List<Subtask>> streamSubtasks({
    required String projectId,
    required String todoId,
  }) {
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
