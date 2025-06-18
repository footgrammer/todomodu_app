import 'package:todomodu_app/features/todo/domain/entities/todo.dart';
import 'package:todomodu_app/features/todo/domain/repositories/todo_repository.dart';
import 'package:todomodu_app/features/todo/domain/repositories/subtask_repository.dart';
import 'package:todomodu_app/features/todo/domain/entities/subtask.dart';

class CreateTodoUseCase {
  final TodoRepository todoRepository;
  final SubtaskRepository subtaskRepository;

  CreateTodoUseCase({
    required this.todoRepository,
    required this.subtaskRepository,
  });

  Future<void> call(Todo todo) async {
    await todoRepository.createTodo(todo);

    for (Subtask subtask in todo.subtasks) {
      await subtaskRepository.createSubtask(subtask);
    }
  }
}
