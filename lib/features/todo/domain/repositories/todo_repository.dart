import 'package:todomodu_app/features/todo/domain/entities/todo.dart';

abstract class TodoRepository {
  Future<void> createTodo(Todo todo);
  Stream<List<Todo>> streamTodos(String projectId);
  Future<void> deleteTodo(String projectId, String todoId);

  Future<void> toggleSubtaskDone({
    required String projectId,
    required String todoId,
    required String subtaskId,
    required bool isDone,
  });

  Future<void> updateTodo(Todo todo);
}