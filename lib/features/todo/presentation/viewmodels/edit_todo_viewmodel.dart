import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../application/usecases/update_todo_usecase.dart';
import '../../domain/entities/subtask.dart';
import '../../domain/entities/todo.dart';
import '../states/edit_todo_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
          subtasks: const [],
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

  Future<void> submit() async {
    final trimmedTitle = state.title.trim();
    if (trimmedTitle.isEmpty) return;

    final subtasksSnapshot = await FirebaseFirestore.instance
        .collection('projects')
        .doc(projectId)
        .collection('subtasks')
        .where('todoId', isEqualTo: todoId)
        .get();

    final subtasks = subtasksSnapshot.docs
        .map((doc) => Subtask.fromMap(doc.data()))
        .toList();

    final todo = Todo(
      id: todoId,
      projectId: projectId,
      title: trimmedTitle,
      startDate: state.startDate,
      endDate: state.endDate,
      isDone: false,
      subtasks: subtasks,
    );

    await updateTodoUseCase(todo);
  }
}
