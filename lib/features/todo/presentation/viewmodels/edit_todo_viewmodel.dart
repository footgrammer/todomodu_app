import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/subtask.dart';
import '../../domain/entities/todo.dart';
import '../../application/usecases/update_todo_usecase.dart';
import '../states/edit_todo_state.dart';

class EditTodoViewModel extends StateNotifier<EditTodoState> {
  final UpdateTodoUseCase updateTodoUseCase;
  final String todoId;
  final String projectId;

  EditTodoViewModel({
    required Todo todo,
    required this.updateTodoUseCase,
  })  : todoId = todo.id,
        projectId = todo.projectId,
        super(EditTodoState(
          id: todo.id,
          projectId: todo.projectId,
          title: todo.title,
          startDate: todo.startDate,
          endDate: todo.endDate,
          subtasks: todo.subtasks,
        ));

  void changeTitle(String title) {
    state = state.copyWith(title: title);
  }

  void changeStartDate(DateTime startDate) {
    state = state.copyWith(startDate: startDate);
  }

  void changeEndDate(DateTime endDate) {
    state = state.copyWith(endDate: endDate);
  }

  void addSubtask() {
    final newSubtask = Subtask(
      id: const Uuid().v4(),
      title: '',
      isDone: false,
    );
    state = state.copyWith(subtasks: [...state.subtasks, newSubtask]);
  }

  void removeSubtask(int index) {
    final newList = [...state.subtasks]..removeAt(index);
    state = state.copyWith(subtasks: newList);
  }

  void changeSubtaskTitle(int index, String title) {
    final updated = [...state.subtasks];
    updated[index] = updated[index].copyWith(title: title);
    state = state.copyWith(subtasks: updated);
  }

  Future<void> submit() async {
    final todo = Todo(
      id: todoId,
      projectId: projectId,
      title: state.title,
      startDate: state.startDate,
      endDate: state.endDate,
      isDone: false,
      subtasks: state.subtasks,
    );
    await updateTodoUseCase(todo);
  }
}
