import '../../domain/repositories/todo_repository.dart';

class ToggleSubtaskDoneUseCase {
  final TodoRepository repository;

  ToggleSubtaskDoneUseCase(this.repository);

  Future<void> call({
    required String projectId,
    required String todoId,
    required String subtaskId,
    required bool isDone,
  }) async {
    await repository.toggleSubtaskDone(
      projectId: projectId,
      todoId: todoId,
      subtaskId: subtaskId,
      isDone: isDone,
    );
  }
}
