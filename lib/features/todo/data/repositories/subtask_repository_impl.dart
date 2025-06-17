import 'package:todomodu_app/features/todo/data/datasources/subtask_datasource.dart';
import 'package:todomodu_app/features/todo/domain/entities/subtask.dart';
import 'package:todomodu_app/features/todo/domain/repositories/subtask_repository.dart';
import 'package:todomodu_app/shared/types/result.dart';

class SubtaskRepositoryImpl implements SubtaskRepository {
  final SubtaskDatasource _dataSource;

  SubtaskRepositoryImpl({required SubtaskDatasource dataSource})
    : _dataSource = dataSource;

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
}
