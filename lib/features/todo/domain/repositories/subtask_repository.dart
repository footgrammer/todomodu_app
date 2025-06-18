import '../entities/subtask.dart';

abstract class SubtaskRepository {
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
}