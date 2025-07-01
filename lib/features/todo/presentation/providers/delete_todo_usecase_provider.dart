import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/activity_history/presentation/providers/activity_history_providers.dart';
import '../../application/usecases/delete_todo_usecase.dart';
import 'todo_repository_provider.dart';

final deleteTodoUseCaseProvider = Provider<DeleteTodoUseCase>((ref) {
  return DeleteTodoUseCase(
    repository: ref.watch(todoRepositoryProvider),
    logActivity: ref.watch(logActivityHistoryUsecaseProvider),
  );
});

