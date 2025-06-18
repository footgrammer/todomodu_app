import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';

class StreamTodosUseCase {
  final TodoRepository repository;

  StreamTodosUseCase(this.repository);

  Stream<List<Todo>> call(String projectId) {
    return repository.streamTodos(projectId);
  }
}
