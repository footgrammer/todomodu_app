import 'package:todomodu_app/shared/types/result.dart';

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
  Future<Result<List<Todo>>> getTodosByProjectId(String projectId) async {
    try {
      final dtoResult = await remoteDataSource.getTodosByProjectId(projectId);
      return switch (dtoResult) {
        Ok(value: final dtos) => Result.ok(
          dtos.map((dto) => dto.toEntity()).toList(),
        ),
        Error(:final error) => Result.error(error),
      };
    } catch (e) {
      return Result.error(Exception('Failed to load todos: $e'));
    }
  }
}
