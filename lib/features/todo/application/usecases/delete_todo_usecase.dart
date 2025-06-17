import '../../domain/repositories/todo_repository.dart';

class DeleteTodoUseCase {
  final TodoRepository repository;

  DeleteTodoUseCase(this.repository);

  Future<void> call(String todoId) async {
    await repository.deleteTodo(todoId);
  }
}
