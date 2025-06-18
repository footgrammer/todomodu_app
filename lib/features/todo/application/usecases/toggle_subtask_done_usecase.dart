import '../../domain/repositories/subtask_repository.dart';

class ToggleSubtaskDoneUseCase {
  final SubtaskRepository repository;

  ToggleSubtaskDoneUseCase(this.repository);

  Future<void> call({
    required String projectId,
    required String todoId,
    required String subtaskId,
    required bool isDone,
  }) async {
    await repository.toggleDone(
      projectId: projectId,
      subtaskId: subtaskId,
      isDone: isDone,
    );
  }
}
