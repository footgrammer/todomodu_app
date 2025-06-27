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

  // 단일 subtask 삭제
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

  // 특정 todo 관련 subtasks 일괄 삭제
  @override
  Future<void> deleteSubtasksByTodoId(String projectId, String todoId) async {
    final collection = _firestore
    .collection('projects')
    .doc(projectId)
    .collection('subtasks');

    final querySnapshot = await collection.where('todoId', isEqualTo: todoId).get();

    for (final doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
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

  if (result is Ok<List<SubtaskDto>>) {
    final dtos = result.value;
    final List<Subtask> entities =
        dtos.map((dto) => dto.toEntity()).toList();
    return Result<List<Subtask>>.ok(entities);
  } else if (result is Error<List<SubtaskDto>>) {
    return Result<List<Subtask>>.error(result.error);
  }

  return Result<List<Subtask>>.error(Exception('Unexpected Result type'));
}

@override
Future<Result<List<Subtask>>> getSubtasksByProjectId(String projectId) async {
  final result = await dataSource.getSubtasksByProjectId(projectId);

  return result.when(
    ok: (dtos) {
      final List<Subtask> entities =
          dtos.map((dto) => dto.toEntity()).toList();
      return Result<List<Subtask>>.ok(entities);
    },
    error: (e) {
      return Result<List<Subtask>>.error(e);
    },
  );
}
}