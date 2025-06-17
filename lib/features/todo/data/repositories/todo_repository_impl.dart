import '../../domain/repositories/todo_repository.dart';
import '../../domain/entities/todo.dart';
import '../datasources/todo_remote_datasource.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDataSource remoteDataSource;

  TodoRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> createTodo(Todo todo) async {
    await remoteDataSource.createTodo(todo);
  }

  @override
  Stream<List<Todo>> streamTodos(String projectId) {
    return remoteDataSource.streamTodos(projectId);
  }

  @override
  Future<void> deleteTodo(String projectId, String todoId) async {
    await remoteDataSource.deleteTodo(projectId, todoId);
  }

  @override
  Future<void> toggleSubtaskDone({
    required String projectId,
    required String todoId,
    required String subtaskId,
    required bool isDone,
  }) async {
    await remoteDataSource.toggleSubtaskDone(
      projectId: projectId,
      todoId: todoId,
      subtaskId: subtaskId,
      isDone: isDone,
    );
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    await remoteDataSource.updateTodo(todo);
  }
}
