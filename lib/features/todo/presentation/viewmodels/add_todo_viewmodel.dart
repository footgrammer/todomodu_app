import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/subtask.dart';
import '../../domain/entities/todo.dart';
import '../../application/usecases/create_todo_usecase.dart';

class AddTodoViewModel extends ChangeNotifier {
  final CreateTodoUseCase createTodoUseCase;

  AddTodoViewModel(this.createTodoUseCase);

  final TextEditingController titleController = TextEditingController();
  final List<TextEditingController> subTaskControllers = [];

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  void addSubTask() {
    subTaskControllers.add(TextEditingController());
    notifyListeners();
  }

  void removeSubTask(int index) {
    subTaskControllers[index].dispose();
    subTaskControllers.removeAt(index);
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

    final List<Subtask> subTasks = subTaskControllers.map((controller) {
      return Subtask(
        id: uuid.v4(),
        todoId: '임시',
        title: controller.text,
        isDone: false,
        assignee: null,
      );
    }).toList();

    final todo = Todo(
      id: uuid.v4(),
      projectId: '임시 프로젝트',
      title: titleController.text,
      subTasks: subTasks,
      startDate: startDate,
      endDate: endDate,
      isDone: false,
    );

    await createTodoUseCase(todo);
  }

  @override
  void dispose() {
    titleController.dispose();
    for (var c in subTaskControllers) {
      c.dispose();
    }
    super.dispose();
  }
}
