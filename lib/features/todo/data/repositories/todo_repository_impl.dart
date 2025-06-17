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
  Stream<List<Todo>> streamTodos() {
    return remoteDataSource.streamTodos();
  }

    @override
  Future<void> deleteTodo(String todoId) async {
    await remoteDataSource.deleteTodo(todoId);
  }
  
   @override
  Future<void> toggleSubTaskDone({
    required String todoId,
    required String subTaskId,
    required bool isDone,
  }) async {
    await remoteDataSource.toggleSubTaskDone(
      todoId: todoId,
      subTaskId: subTaskId,
      isDone: isDone,
    );
  }
}
