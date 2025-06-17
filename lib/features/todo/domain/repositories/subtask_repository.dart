import 'package:todomodu_app/features/todo/domain/entities/subtask.dart';
import 'package:todomodu_app/shared/types/result.dart';

abstract interface class SubtaskRepository {
  Future<Result<List<Subtask>>> getSubtasksByProjectId(String projectId);
  Future<Result<List<Subtask>>> getSubtasksByProjectAndTodoId(String projectId, String todoId);
}