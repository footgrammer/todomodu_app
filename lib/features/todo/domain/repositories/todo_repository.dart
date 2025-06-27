import 'package:todomodu_app/features/todo/domain/entities/todo.dart';
import 'package:todomodu_app/shared/types/result.dart';

abstract class TodoRepository {
  Future<void> createTodo(Todo todo);
  Future<Result<List<Todo>>> getTodosByProjectId(String projectId);
  Future<Result<List<Todo>>> getTodosWithSubtasksByProjectId(String projectId);

  Stream<List<Todo>> streamTodos(String projectId);

  //단일 todo 조회
  Stream<Todo> streamTodoById(String projectId, String todoId);

  Future<void> deleteTodo(String projectId, String todoId);

  Future<void> toggleSubtaskDone({
    required String projectId,
    required String todoId,
    required String subtaskId,
    required bool isDone,
  });

  Future<void> updateTodo(Todo todo);
}
