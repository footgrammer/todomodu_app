import 'package:todomodu_app/features/todo/domain/entities/todo.dart';

abstract class TodoRepository {
  Future<void> createTodo(Todo todo);
  Stream<List<Todo>> streamTodos();
}
