import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/todo/application/usecases/create_todo_usecase.dart';
import 'package:todomodu_app/features/todo/data/repositories/todo_repository_impl.dart';

final todoRepositoryProvider = Provider<TodoRepositoryImpl>((ref) {
  return TodoRepositoryImpl();
});

final Provider<CreateTodoUseCase> createTodoUseCaseProvider = Provider((ref) {
  final repository = ref.read(todoRepositoryProvider);
  return CreateTodoUseCase(repository);
});