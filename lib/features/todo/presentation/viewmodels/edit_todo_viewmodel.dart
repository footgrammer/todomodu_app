import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/sub_task.dart';
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
          subTasks: todo.subTasks,
        ));

  // 제목 수정
  void changeTitle(String title) {
    state = state.copyWith(title: title);
  }

  // 시작일 수정
  void changeStartDate(DateTime startDate) {
    state = state.copyWith(startDate: startDate);
  }

  // 종료일 수정
  void changeEndDate(DateTime endDate) {
    state = state.copyWith(endDate: endDate);
  }

  // SubTask 추가 (uuid로 임시 id 부여)
  void addSubTask() {
    final newSubTask = SubTask(
      id: const Uuid().v4(),
      todoId: todoId,
      title: '',
      isDone: false,
    );
    state = state.copyWith(subTasks: [...state.subTasks, newSubTask]);
  }

  // SubTask 삭제
  void removeSubTask(int index) {
    final newList = [...state.subTasks]..removeAt(index);
    state = state.copyWith(subTasks: newList);
  }

  // SubTask 제목 수정
  void changeSubTaskTitle(int index, String title) {
    final updated = [...state.subTasks];
    updated[index] = updated[index].copyWith(title: title);
    state = state.copyWith(subTasks: updated);
  }

  // 제출 (Firestore로 업데이트)
  Future<void> submit() async {
    final todo = Todo(
      id: todoId,
      projectId: projectId,
      title: state.title,
      startDate: state.startDate,
      endDate: state.endDate,
      isDone: false,
      subTasks: state.subTasks,
    );
    await updateTodoUseCase(todo);
  }
}