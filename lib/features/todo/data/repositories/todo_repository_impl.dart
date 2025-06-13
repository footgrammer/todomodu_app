import 'package:todomodu_app/features/todo/data/datasources/todo_remote_datasource.dart';
import 'package:todomodu_app/features/todo/domain/entities/todo.dart';
import 'package:todomodu_app/features/todo/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDatasource remoteDatasource;

  TodoRepositoryImpl(this.remoteDatasource);

  @override
  Future<void> createTodo(Todo todo) async {
    await remoteDatasource.createTodo(todo);
  }

  @override
  Future<List<Todo>> fetchTodos() async {
    return await remoteDatasource.fetchTodos();
  }
}
