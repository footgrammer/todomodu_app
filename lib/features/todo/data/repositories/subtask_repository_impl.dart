import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todomodu_app/shared/types/result.dart';
import '../../domain/entities/subtask.dart';
import '../../domain/repositories/subtask_repository.dart';
import '../datasources/subtask_datasource.dart';
import '../models/subtask_dto.dart';
import 'package:todomodu_app/shared/types/result_extension.dart';

class SubtaskRepositoryImpl implements SubtaskRepository {
  final SubtaskDatasource dataSource;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  SubtaskRepositoryImpl({required this.dataSource,});

  @override
  Stream<List<Subtask>> streamSubtasks(String projectId, String todoId) {
    return _firestore
      .collection('projects')
      .doc(projectId)
      .collection('subtasks')
      .where('todoId', isEqualTo: todoId)
      .snapshots()
      .map((snap) =>
        snap.docs
          .map((doc) => SubtaskDto.fromJson(doc.data(), id: doc.id).toEntity())
          .toList()
      );
  }

  @override
  Future<void> createSubtask(Subtask subtask) async {
    final dto = SubtaskDto.fromEntity(subtask);
    await _firestore
        .collection('projects')
        .doc(subtask.projectId)
        .collection('subtasks')
        .doc(subtask.id)
        .set(dto.toJson());
  }

  @override
  Future<void> updateSubtask(Subtask subtask) async {
    final dto = SubtaskDto.fromEntity(subtask);
    await _firestore
        .collection('projects')
        .doc(subtask.projectId)
        .collection('subtasks')
        .doc(subtask.id)
        .update(dto.toJson());
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

  @override
  Future<Result<List<Subtask>>> getSubtasksByProjectAndTodoId(
    String projectId,
    String todoId,
  ) async {
    final result = await dataSource.getSubtasksByProjectAndTodoId(projectId, todoId);
    return result.when(
      ok: (dtos) => Result.ok(dtos.map((dto) => dto.toEntity()).toList()),
      error: (e) => Result.error(e),
    );
  }

  @override
  Future<Result<List<Subtask>>> getSubtasksByProjectId(String projectId) async {
    final result = await dataSource.getSubtasksByProjectId(projectId);
    return result.when(
      ok: (dtos) => Result.ok(dtos.map((dto) => dto.toEntity()).toList()),
      error: (e) => Result.error(e),
    );
  }
}