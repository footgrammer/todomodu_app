import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/subtask.dart';
import '../../domain/entities/todo.dart';
import '../../application/usecases/create_todo_usecase.dart';

class AddTodoViewModel extends ChangeNotifier {
  final CreateTodoUseCase createTodoUseCase;
  final String projectId;

  AddTodoViewModel(this.createTodoUseCase, {required this.projectId});

  final TextEditingController titleController = TextEditingController();
  final List<TextEditingController> subtaskControllers = [];

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  void addSubtask() {
    subtaskControllers.add(TextEditingController());
    notifyListeners();
  }

  void removeSubtask(int index) {
    subtaskControllers[index].dispose();
    subtaskControllers.removeAt(index);
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
        if (startDate.isAfter(endDate)) {
          endDate = startDate;
        }
      } else {
        if (picked.isBefore(startDate)) {
          endDate = startDate;
        } else {
          endDate = picked;
        }
      }
      notifyListeners();
    }
  }

  Future<void> submit() async {
    final uuid = Uuid();

    final List<Subtask> subtasks = subtaskControllers.map((controller) {
      return Subtask(
        id: uuid.v4(),
        title: controller.text,
        isDone: false,
      );
    }).toList();

    final todo = Todo(
      id: uuid.v4(),
      projectId: projectId,
      title: titleController.text,
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
    for (var c in subtaskControllers) {
      c.dispose();
    }
    super.dispose();
  }
}
