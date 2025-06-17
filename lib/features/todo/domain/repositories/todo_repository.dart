import 'package:todomodu_app/features/todo/domain/entities/todo.dart';
import 'package:todomodu_app/shared/types/result.dart';

abstract class TodoRepository {
  Future<void> createTodo(Todo todo);
  Stream<List<Todo>> streamTodos();
  Future<Result<List<Todo>>> getTodosByProjectId(String projectId);

}
