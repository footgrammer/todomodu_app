import 'package:todomodu_app/features/todo/domain/entities/todo.dart';
import 'package:todomodu_app/features/todo/domain/repositories/todo_repository.dart';

class CreateTodoUseCase {
  final TodoRepository repository;

  CreateTodoUseCase(this.repository);

  Future<void> call(Todo todo) {
    return repository.createTodo(todo);
  }
}