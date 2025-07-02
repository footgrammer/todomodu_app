import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/activity_history/presentation/providers/activity_history_providers.dart';
import '../../application/usecases/update_todo_usecase.dart';
import 'todo_repository_provider.dart';

final updateTodoUseCaseProvider = Provider<UpdateTodoUseCase>((ref) {
  final repository = ref.watch(todoRepositoryProvider);
  final logActivity = ref.watch(logActivityHistoryUsecaseProvider);

  return UpdateTodoUseCase(
    repository: repository,
    logActivity: logActivity,
  );
});