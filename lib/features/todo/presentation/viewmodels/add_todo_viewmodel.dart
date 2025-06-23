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

  AddTodoViewModel(this.createTodoUseCase, {required this.projectId});

  final TextEditingController titleController = TextEditingController();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  final String pendingTodoId = const Uuid().v4();

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

  Future<void> submitWithSubtasks() async {
    final trimmedTitle = titleController.text.trim();
    if (trimmedTitle.isEmpty) return;

    final subtasksSnapshot = await FirebaseFirestore.instance
        .collection('projects')
        .doc(projectId)
        .collection('subtasks')
        .where('todoId', isEqualTo: pendingTodoId)
        .get();

    final subtasks = subtasksSnapshot.docs.map((doc) {
      return SubtaskDto.fromJson(doc.data(), id: doc.id).toEntity();
    }).toList();

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
    titleController.dispose();
    super.dispose();
  }
}
