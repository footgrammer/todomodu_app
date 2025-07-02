import 'package:todomodu_app/features/activity_history/domain/models/activity_history_payload.dart';
import 'package:todomodu_app/features/todo/domain/entities/todo.dart';
import 'package:todomodu_app/features/todo/domain/entities/subtask.dart';
import 'package:todomodu_app/features/todo/domain/repositories/todo_repository.dart';
import 'package:todomodu_app/features/todo/domain/repositories/subtask_repository.dart';
import 'package:todomodu_app/features/activity_history/domain/entities/activity_history.dart';
import 'package:todomodu_app/features/activity_history/domain/usecases/log_activity_history_usecase.dart';

class CreateTodoUseCase {
  final TodoRepository todoRepository;
  final SubtaskRepository subtaskRepository;
  final LogActivityHistoryUsecase logActivityHistoryUsecase;

  CreateTodoUseCase({
    required this.todoRepository,
    required this.subtaskRepository,
    required this.logActivityHistoryUsecase,
  });

  Future<void> call(Todo todo) async {
    await todoRepository.createTodo(todo);

    for (Subtask subtask in todo.subtasks) {
      await subtaskRepository.createSubtask(subtask);
    }

    final log = ActivityHistory(
      id: '',
      projectId: todo.projectId,
      createdAt: DateTime.now(),
      payload: ActivityHistoryPayload.todoAdded(
        todoId: todo.id,
        title: todo.title,
      ),
    );

    await logActivityHistoryUsecase.execute(log);
  }
}
