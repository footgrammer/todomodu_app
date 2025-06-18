import 'package:todomodu_app/features/todo/data/datasources/subtask_datasource.dart';
import 'package:todomodu_app/features/todo/domain/entities/subtask.dart';
import 'package:todomodu_app/features/todo/domain/repositories/subtask_repository.dart';
import 'package:todomodu_app/shared/types/result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SubtaskRepositoryImpl implements SubtaskRepository {
  final SubtaskDatasource _dataSource;
  final FirebaseFirestore _firestore;

  SubtaskRepositoryImpl({
    required SubtaskDatasource dataSource,
    required FirebaseFirestore firestore,
  }) : _dataSource = dataSource,
       _firestore = firestore;

  @override
  Future<Result<List<Subtask>>> getSubtasksByProjectId(String projectId) async {
    final result = await _dataSource.getSubtasksByProjectId(projectId);
    return switch (result) {
      Ok(value: final dtos) => Result.ok(
        dtos.map((dto) => dto.toEntity(assignee: null)).toList(),
      ),
      Error(:final error) => Result.error(error),
    };
  }

  @override
  Future<Result<List<Subtask>>> getSubtasksByProjectAndTodoId(
    String projectId,
    String todoId,
  ) async {
    final result = await _dataSource.getSubtasksByProjectAndTodoId(
      projectId,
      todoId,
    );

    return switch (result) {
      Ok(value: final dtos) => Result.ok(
        dtos.map((dto) => dto.toEntity(assignee: null)).toList(),
      ),
      Error(:final error) => Result.error(error),
    };
  }

  @override
  Stream<List<Subtask>> streamSubtasks(String projectId, String todoId) {
    return _firestore
        .collection('projects')
        .doc(projectId)
        .collection('subtasks')
        .where('todoId', isEqualTo: todoId)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Subtask.fromMap(doc.data())).toList(),
        );
  }

  @override
  Future<void> createSubtask(Subtask subtask) async {
    final docRef = _firestore
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
    await _firestore
        .collection('projects')
        .doc(projectId)
        .collection('subtasks')
        .doc(subtaskId)
        .delete();
  }

  @override
  Future<void> updateSubtask(Subtask subtask) async {
    await _firestore
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
    await _firestore
        .collection('projects')
        .doc(projectId)
        .collection('subtasks')
        .doc(subtaskId)
        .update({'isDone': isDone});
  }
}
