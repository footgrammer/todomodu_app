import 'dart:developer';

import 'package:todomodu_app/features/todo/data/models/todo_dto.dart';
import 'package:todomodu_app/features/todo/domain/entities/subtask.dart';
import 'package:todomodu_app/features/todo/domain/repositories/subtask_repository.dart';
import 'package:todomodu_app/shared/types/result.dart';

import '../../domain/repositories/todo_repository.dart';
import '../../domain/entities/todo.dart';
import '../datasources/todo_remote_datasource.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDataSource _remoteDataSource;
  final SubtaskRepository _subtaskRepository;

  TodoRepositoryImpl({
    required TodoRemoteDataSource remoteDataSource,
    required SubtaskRepository subtaskRepository,
  }) : _remoteDataSource = remoteDataSource,
       _subtaskRepository = subtaskRepository;

  @override
  Future<void> createTodo(Todo todo) async {
    await _remoteDataSource.createTodo(todo);
  }

  Stream<List<Todo>> streamTodos(String projectId) {
    return _remoteDataSource.streamTodos(projectId);
  }

  @override
  Future<Result<List<Todo>>> getTodosByProjectId(String projectId) async {
    try {
      final dtoResult = await _remoteDataSource.getTodosByProjectId(projectId);
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

  @override
  Future<Result<List<Todo>>> getTodosWithSubtasksByProjectId(
    String projectId,
  ) async {
    final todosResult = await _remoteDataSource.getTodosByProjectId(projectId);
    if (todosResult is! Ok<List<TodoDto>>) {
      log('❗ getTodosWithSubtasksByProjectId, error: $todosResult');
      return Result.error(Exception('Todo load failed'));
    }
    final todoDtos = todosResult.value;

    final subtasksResult = await _subtaskRepository.getSubtasksByProjectId(
      projectId,
    );
    if (subtasksResult is! Ok<List<Subtask>>) {
      log('❗ getSubtasksByProjectId, error: $subtasksResult');
      return Result.error(Exception('Subtask load failed'));
    }
    final subtasks = subtasksResult.value;

    // Group subtasks by todoId
    final subtaskMap = <String, List<Subtask>>{};
    for (final sub in subtasks) {
      subtaskMap.putIfAbsent(sub.todoId, () => []).add(sub);
    }

    final todos =
        todoDtos.map((dto) {
          final subtasks = subtaskMap[dto.id] ?? [];
          return dto.toEntity(subTasks: subtasks);
        }).toList();

    return Result.ok(todos);
  }

  @override
  Future<void> deleteTodo(String projectId, String todoId) async {
    await _remoteDataSource.deleteTodo(projectId, todoId);
  }

  @override
  Future<void> toggleSubtaskDone({
    required String projectId,
    required String todoId,
    required String subtaskId,
    required bool isDone,
  }) async {
    await _remoteDataSource.toggleSubtaskDone(
      projectId: projectId,
      todoId: todoId,
      subtaskId: subtaskId,
      isDone: isDone,
    );
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    await _remoteDataSource.updateTodo(todo);
  }
}
