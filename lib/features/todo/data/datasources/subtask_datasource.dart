import 'package:todomodu_app/features/todo/data/models/subtask_dto.dart';
import 'package:todomodu_app/shared/types/result.dart';

abstract interface class SubtaskDatasource {
  Future<Result<List<SubtaskDto>>> getSubtasksByProjectAndTodoId(String projectId, String todoId);
  Future<Result<List<SubtaskDto>>> getSubtasksByProjectId(String projectId);
}