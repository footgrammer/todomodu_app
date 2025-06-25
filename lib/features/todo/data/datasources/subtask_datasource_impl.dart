import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todomodu_app/features/todo/data/datasources/subtask_datasource.dart';
import 'package:todomodu_app/features/todo/data/models/subtask_dto.dart';
import 'package:todomodu_app/shared/types/result.dart';

class SubtaskDatasourceImpl implements SubtaskDatasource {
  final FirebaseFirestore _firestore;

  SubtaskDatasourceImpl({required FirebaseFirestore firestore})
    : _firestore = firestore;

  @override
  Future<Result<List<SubtaskDto>>> getSubtasksByProjectId(
    String projectId,
  ) async {
    try {
      final snapshot =
          await _firestore
              .collection('projects')
              .doc(projectId)
              .collection('subtasks')
              .get();

      final dtos =
          snapshot.docs
              .map((doc) {
                try {
                  final data = doc.data();
                  return SubtaskDto.fromJson(data, id: doc.id);
                } catch (e) {
                  log('❌ SubtaskDto.fromJson 실패 (docId: ${doc.id})\nerror: $e');
                  return null;
                }
              })
              .whereType<SubtaskDto>()
              .toList();

      return Result.ok(dtos);
    } catch (e, stack) {
      log('❌ Subtask 불러오기 실패 (projectId: $projectId)\n$e\n$stack');
      return Result.error(
        Exception('Failed to load subtasks by projectId: $e'),
      );
    }
  }

  @override
  Future<Result<List<SubtaskDto>>> getSubtasksByProjectAndTodoId(
    String projectId,
    String todoId,
  ) async {
    try {
      final snapshot =
          await _firestore
              .collection('projects')
              .doc(projectId)
              .collection('subtasks')
              .where('todoId', isEqualTo: todoId)
              .get();

      final dtos =
          snapshot.docs.map((doc) {
            final data = doc.data();
            return SubtaskDto.fromJson(data, id: doc.id);
          }).toList();

      return Result.ok(dtos);
    } catch (e) {
      return Result.error(
        Exception('Failed to load subtasks by projectId and todoId: $e'),
      );
    }
  }
}
