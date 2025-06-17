import 'package:todomodu_app/features/todo/domain/entities/todo.dart';

abstract class TodoRepository {
  Future<void> createTodo(Todo todo);
  Stream<List<Todo>> streamTodos();
  Future<void> deleteTodo(String todoId);

    Future<void> toggleSubTaskDone({
    required String todoId,
    required String subTaskId,
    required bool isDone,
}
    );
}