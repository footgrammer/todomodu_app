import 'package:todomodu_app/features/todo/domain/entities/subtask.dart';
import 'package:todomodu_app/shared/types/result.dart';

abstract interface class SubtaskRepository {
  Stream<List<Subtask>> streamSubtasks(String projectId, String todoId);
  Future<void> toggleDone({
    required String projectId,
    required String subtaskId,
    required bool isDone,
  });
  Future<void> updateSubtask(Subtask subtask);
  Future<void> deleteSubtask({
    required String projectId,
    required String subtaskId,
  });
  Future<void> createSubtask(Subtask subtask);

  Future<Result<List<Subtask>>> getSubtasksByProjectId(String projectId);
  Future<Result<List<Subtask>>> getSubtasksByProjectAndTodoId(String projectId, String todoId);
}