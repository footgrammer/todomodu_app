import '../../domain/repositories/todo_repository.dart';

class ToggleSubTaskDoneUseCase {
  final TodoRepository repository;

  ToggleSubTaskDoneUseCase(this.repository);

  Future<void> call({
    required String todoId,
    required String subTaskId,
    required bool isDone,
  }) async {
    await repository.toggleSubTaskDone(
      todoId: todoId,
      subTaskId: subTaskId,
      isDone: isDone,
    );
  }
}
