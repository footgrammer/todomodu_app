import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/subtask.dart';
import '../../domain/entities/todo.dart';
import '../../application/usecases/create_todo_usecase.dart';
import '../../data/models/subtask_dto.dart';

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

  ///  제출 버튼 활성화 조건
  bool get canSubmit {
    final trimmedTitle = titleController.text.trim();
    return trimmedTitle.isNotEmpty && startDate != null && endDate != null;
  }

  /// 제목 입력 감지 시 상태 갱신
  void _onTitleChanged() {
    notifyListeners(); // 버튼 활성화 상태 갱신
  }

  /// 🔹 날짜 선택
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
      notifyListeners(); // 변경 감지
    }
  }

  /// 할 일 + 세부 할 일 저장
  Future<void> submitWithSubtasks() async {
    final trimmedTitle = titleController.text.trim();
    if (trimmedTitle.isEmpty) return;

    final subtasksSnapshot =
        await FirebaseFirestore.instance
            .collection('projects')
            .doc(projectId)
            .collection('subtasks')
            .where('todoId', isEqualTo: pendingTodoId)
            .get();

    final subtasks =
        subtasksSnapshot.docs
            .map(
              (doc) => SubtaskDto.fromJson(doc.data(), id: doc.id).toEntity(),
            )
            .where((subtask) => subtask.title.trim().isNotEmpty)
            .toList();

    // subtasks 비어 있으면 자동 생성
    if (subtasks.isEmpty) {
      subtasks.add(
        Subtask(
          id: const Uuid().v4(),
          title: trimmedTitle,
          isDone: false,
          todoId: pendingTodoId,
          projectId: projectId,
        ),
      );
    }

    final todo = Todo(
      id: pendingTodoId,
      projectId: projectId,
      title: trimmedTitle,
      subtasks: subtasks,
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
