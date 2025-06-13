import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/todo/application/usecases/create_todo_usecase.dart';
import 'package:todomodu_app/features/todo/presentation/providers/todo_repository_provider.dart';

final createTodoUseCaseProvider = Provider<CreateTodoUseCase>((ref) {
  final repository = ref.read(todoRepositoryProvider);
  return CreateTodoUseCase(repository);
});