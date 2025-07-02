import 'package:todomodu_app/features/activity_history/domain/entities/activity_history.dart';
import 'package:todomodu_app/features/activity_history/domain/models/activity_history_payload.dart';
import 'package:todomodu_app/features/activity_history/domain/usecases/log_activity_history_usecase.dart';
import '../../domain/repositories/todo_repository.dart';

class DeleteTodoUseCase {
  final TodoRepository repository;
  final LogActivityHistoryUsecase logActivity;

  DeleteTodoUseCase({
    required this.repository,
    required this.logActivity,
  });

  Future<void> call({
    required String projectId,
    required String todoId,
  }) async {
    await repository.deleteTodo(projectId, todoId);

    final history = ActivityHistory(
      id: '',
      projectId: projectId,
      createdAt: DateTime.now(),
      payload: ActivityHistoryPayload.todoDeleted(todoId: todoId),
    );

    await logActivity.execute(history);
  }
}
