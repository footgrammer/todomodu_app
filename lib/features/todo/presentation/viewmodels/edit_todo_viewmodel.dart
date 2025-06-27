import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todomodu_app/features/todo/data/models/subtask_dto.dart';
import 'package:uuid/uuid.dart';
import '../../application/usecases/update_todo_usecase.dart';
import '../../domain/entities/subtask.dart';
import '../../domain/entities/todo.dart';
import '../states/edit_todo_state.dart';

class EditTodoViewModel extends StateNotifier<EditTodoState> {
  final UpdateTodoUseCase updateTodoUseCase;
  final String todoId;
  final String projectId;

  bool get canSubmit {
    return state.title.trim().isNotEmpty &&
        state.startDate != null &&
        state.endDate != null;
  }

  EditTodoViewModel({required Todo todo, required this.updateTodoUseCase})
    : todoId = todo.id,
      projectId = todo.projectId,
      super(
        EditTodoState(
          id: todo.id,
          projectId: todo.projectId,
          title: todo.title,
          startDate: todo.startDate,
          endDate: todo.endDate,
          subtasks: const [],
        ),
      );

  void changeTitle(String title) {
    state = state.copyWith(title: title);
  }

  void changeStartDate(DateTime startDate) {
    state = state.copyWith(startDate: startDate);
  }

  void changeEndDate(DateTime endDate) {
    state = state.copyWith(endDate: endDate);
  }

  void addSubtask(Subtask subtask) {
    state = state.copyWith(subtasks: [...state.subtasks, subtask]);
  }

  void updateSubtask(Subtask updated) {
    state = state.copyWith(
      subtasks:
          state.subtasks.map((s) => s.id == updated.id ? updated : s).toList(),
    );
  }

  void removeSubtask(String id) {
    state = state.copyWith(
      subtasks: state.subtasks.where((s) => s.id != id).toList(),
    );
  }

Future<void> submit() async {
  final trimmedTitle = state.title.trim();
  if (trimmedTitle.isEmpty) return;

  // 유효한 서브태스크만 필터링
  final validSubtasks = state.subtasks
      .where((s) => s.title.trim().isNotEmpty)
      .map((s) => s.copyWith(
            todoId: todoId,
            projectId: projectId,
          ))
      .toList();

  // 모두 제거된 경우, 제목 기반 서브태스크 하나 생성
  if (validSubtasks.isEmpty) {
    validSubtasks.add(Subtask(
      id: const Uuid().v4(),
      title: trimmedTitle,
      isDone: false,
      todoId: todoId,
      projectId: projectId,
    ));
  }

  final snapshot = await FirebaseFirestore.instance
      .collection('projects')
      .doc(projectId)
      .collection('subtasks')
      .where('todoId', isEqualTo: todoId)
      .get();

  final existingIds = snapshot.docs.map((doc) => doc.id).toSet();
  final currentIds = validSubtasks.map((s) => s.id).toSet();

  final deletedIds = existingIds.difference(currentIds);

    for (final id in deletedIds) {
    await FirebaseFirestore.instance
        .collection('projects')
        .doc(projectId)
        .collection('subtasks')
        .doc(id)
        .delete();
  }

  final todo = Todo(
    id: todoId,
    projectId: projectId,
    title: trimmedTitle,
    startDate: state.startDate,
    endDate: state.endDate,
    isDone: false,
    subtasks: validSubtasks,
  );

  await updateTodoUseCase(todo);
}
}
