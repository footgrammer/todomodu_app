import 'package:todomodu_app/features/todo/domain/entities/todo.dart';
import 'package:todomodu_app/features/todo/domain/repositories/todo_repository.dart';

class FetchTodosUsecase {
  final TodoRepository repository;

  FetchTodosUsecase(this.repository);

  Future<List<Todo>> call() {
    return repository.fetchTodos();
  }
}