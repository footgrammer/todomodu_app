import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/subtask.dart';
import '../../domain/entities/todo.dart';
import '../../application/usecases/create_todo_usecase.dart';

class AddTodoViewModel extends ChangeNotifier {
  final CreateTodoUseCase createTodoUseCase;
  final String projectId;

  AddTodoViewModel(this.createTodoUseCase, {required this.projectId}) {
    titleController.addListener(_onTitleChanged);
  }

  final TextEditingController titleController = TextEditingController();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  final String pendingTodoId = const Uuid().v4();

  List<Subtask> _subtasks = [];

  List<Subtask> get subtasks => _subtasks;

  /// 버튼 활성화 조건
  bool get canSubmit {
    final trimmedTitle = titleController.text.trim();
    return trimmedTitle.isNotEmpty && startDate != null && endDate != null;
  }

  void _onTitleChanged() {
    notifyListeners();
  }

  Future<void> pickDate(BuildContext context, bool isStart) async {
    final DateTime initial = isStart ? startDate : endDate;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      if (isStart) {
        startDate = picked;
        if (startDate.isAfter(endDate)) endDate = startDate;
      } else {
        endDate = picked.isBefore(startDate) ? startDate : picked;
      }
      notifyListeners();
    }
  }

  /// Subtask 조작 메서드
  void addSubtask(Subtask subtask) {
    _subtasks = [..._subtasks, subtask];
    notifyListeners();
  }

  void updateSubtask(Subtask updated) {
    _subtasks = _subtasks.map((s) => s.id == updated.id ? updated : s).toList();
    notifyListeners();
  }

  void removeSubtask(String id) {
    _subtasks = _subtasks.where((s) => s.id != id).toList();
    notifyListeners();
  }

  /// 제출 시 메모리에서 바로 저장
  Future<void> submitWithSubtasks() async {
    final trimmedTitle = titleController.text.trim();
    if (trimmedTitle.isEmpty) return;

    final validSubtasks = _subtasks
        .where((s) => s.title.trim().isNotEmpty)
        .map((s) => s.copyWith(
              todoId: pendingTodoId,
              projectId: projectId,
            ))
        .toList();

    if (validSubtasks.isEmpty) {
      validSubtasks.add(Subtask(
        id: const Uuid().v4(),
        title: trimmedTitle,
        isDone: false,
        todoId: pendingTodoId,
        projectId: projectId,
      ));
    }

    final todo = Todo(
      id: pendingTodoId,
      projectId: projectId,
      title: trimmedTitle,
      subtasks: validSubtasks,
      startDate: startDate,
      endDate: endDate,
      isDone: false,
    );

    await createTodoUseCase(todo);
  }

  @override
  void dispose() {
    titleController.removeListener(_onTitleChanged);
    titleController.dispose();
    super.dispose();
  }
}
