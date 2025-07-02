import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/activity_history/presentation/providers/activity_history_providers.dart';
import 'package:todomodu_app/features/todo/application/usecases/create_todo_usecase.dart';
import 'package:todomodu_app/features/todo/presentation/providers/subtask/subtask_provider.dart';
import 'package:todomodu_app/features/todo/presentation/providers/todo_repository_provider.dart';


final createTodoUseCaseProvider = Provider<CreateTodoUseCase>((ref) {
  final todoRepository = ref.watch(todoRepositoryProvider);
  final subtaskRepository = ref.watch(subtaskRepositoryProvider);
  final logActivityHistoryUsecase = ref.watch(logActivityHistoryUsecaseProvider); // ✅ 추가

  return CreateTodoUseCase(
    todoRepository: todoRepository,
    subtaskRepository: subtaskRepository,
    logActivityHistoryUsecase: logActivityHistoryUsecase, // ✅ 주입
  );
});

