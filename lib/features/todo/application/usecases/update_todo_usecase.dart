import 'package:todomodu_app/features/activity_history/domain/entities/activity_history.dart';
import 'package:todomodu_app/features/activity_history/domain/models/activity_history_payload.dart';
import 'package:todomodu_app/features/activity_history/domain/usecases/log_activity_history_usecase.dart';

import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';

class UpdateTodoUseCase {
  final TodoRepository repository;
  final LogActivityHistoryUsecase logActivity;

  UpdateTodoUseCase({
    required this.repository,
    required this.logActivity,
  });

  Future<void> call(Todo todo,) async {
    // 1. 업데이트 수행
    await repository.updateTodo(todo);

    // 2. 변경 내역 로깅
    final history = ActivityHistory(
      id: '', // Firestore에서 auto-id 사용 예정
      projectId: todo.projectId,
      createdAt: DateTime.now(),
      payload: ActivityHistoryPayload.todoUpdated(
        todoId: todo.id,
        changes: {}, // 변경된 내용 비교해서 넣고 싶다면 별도 처리 필요
      ),
    );

    await logActivity.execute(history);
  }
}
