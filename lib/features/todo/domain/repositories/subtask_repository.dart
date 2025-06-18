import '../entities/subtask.dart';

abstract class SubtaskRepository {
  Future<void> createSubtask(Subtask subtask);
  Future<void> updateSubtask(Subtask subtask);
  Future<void> deleteSubtask({
    required String projectId,
    required String subtaskId,
  });
  Stream<List<Subtask>> streamSubtasks({
    required String projectId,
    required String todoId,
  });

  Future<void> toggleDone({
    required String projectId,
    required String subtaskId,
    required bool isDone,
  });
}
