import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class StreamTodosUseCase {
  final TodoRepository repository;

  StreamTodosUseCase(this.repository);

  Stream<List<Todo>> call() {
    return repository.streamTodos();
  }
}