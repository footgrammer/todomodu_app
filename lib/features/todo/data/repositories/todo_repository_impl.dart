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
}
