import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todomodu_app/features/todo/data/models/subtask_dto.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/features/user/domain/usecases/get_user_by_user_id_usecase.dart';
import 'package:uuid/uuid.dart';
import '../../application/usecases/update_todo_usecase.dart';
import '../../domain/entities/subtask.dart';
import '../../domain/entities/todo.dart';
import '../states/edit_todo_state.dart';

class EditTodoViewModel extends StateNotifier<EditTodoState> {
  final UpdateTodoUseCase updateTodoUseCase;
  final String todoId;
  final String projectId;
  final GetUserByUserIdUsecase getUserById;

  bool get canSubmit {
    return state.title.trim().isNotEmpty &&
        state.startDate != null &&
        state.endDate != null;
  }

  EditTodoViewModel({required Todo todo, required this.updateTodoUseCase, required this.getUserById})
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
          isLoading: true,
        )) {
          _loadSubtasks();
        }

Future<void> _loadSubtasks() async {
  state = state.copyWith(isLoading: true);

  final snapshot = await FirebaseFirestore.instance
      .collection('projects')
      .doc(projectId)
      .collection('subtasks')
      .where('todoId', isEqualTo: todoId)
      .get();

  final loadedSubtasks = await Future.wait(snapshot.docs.map((doc) async {
    final dto = SubtaskDto.fromJson(doc.data(), id: doc.id);

    List<UserEntity>? assignee;
    if (dto.assigneeId != null && dto.assigneeId!.isNotEmpty) {
      final users = await Future.wait(
        dto.assigneeId!.map((id) async {
          try {
            return await getUserById.execute(id).first;
          } catch (_) {
            return null;
          }
        }),
      );
      assignee = users.whereType<UserEntity>().toList();
    }

    return dto.toEntity(assignee: assignee);
  }));

  state = state.copyWith(
    subtasks: loadedSubtasks,
    isLoading: false,
  );

  state = state.copyWith(subtasks: loadedSubtasks);
}


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
