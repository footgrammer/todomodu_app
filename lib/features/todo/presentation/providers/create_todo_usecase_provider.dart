import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/todo/application/usecases/create_todo_usecase.dart';
import 'package:todomodu_app/features/todo/presentation/providers/subtask/subtask_providers.dart';
import 'package:todomodu_app/features/todo/presentation/providers/todo_repository_provider.dart';


final createTodoUseCaseProvider = Provider<CreateTodoUseCase>((ref) {
  final todoRepository = ref.watch(todoRepositoryProvider);
  final subtaskRepository = ref.watch(subtaskRepositoryProvider);
  return CreateTodoUseCase(
    todoRepository: todoRepository,
    subtaskRepository: subtaskRepository,
  );
});
