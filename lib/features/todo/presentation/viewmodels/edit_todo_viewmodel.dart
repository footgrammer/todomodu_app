import 'package:flutter/material.dart';
import 'package:todomodu_app/features/todo/application/usecases/update_todo_usecase.dart';
import '../../domain/entities/sub_task.dart';
import '../../domain/entities/todo.dart';
import '../providers/update_todo_usecase_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditTodoViewModel {
  final Todo originalTodo;
  final TextEditingController titleController;
  final List<TextEditingController> subTaskControllers;
  DateTime startDate;
  DateTime endDate;
  final UpdateTodoUseCase updateTodoUseCase;

  EditTodoViewModel({
    required this.originalTodo,
    required this.titleController,
    required this.subTaskControllers,
    required this.startDate,
    required this.endDate,
    required this.updateTodoUseCase,
  });

  factory EditTodoViewModel.create({
    required Todo todo,
    required UpdateTodoUseCase updateTodoUseCase,
  }) {
    return EditTodoViewModel(
      originalTodo: todo,
      titleController: TextEditingController(text: todo.title),
      subTaskControllers: todo.subTasks
          .map((subTask) => TextEditingController(text: subTask.title))
          .toList(),
      startDate: todo.startDate,
      endDate: todo.endDate,
      updateTodoUseCase: updateTodoUseCase,
    );
  }

  void addSubTask() {
    subTaskControllers.add(TextEditingController());
  }

  void removeSubTask(int index) {
    subTaskControllers.removeAt(index);
  }

  Future<void> pickDate(BuildContext context, bool isStartDate) async {
    final initialDate = isStartDate ? startDate : endDate;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      if (isStartDate) {
        startDate = picked;
      } else {
        endDate = picked;
      }
    }
  }

  Future<void> submit() async {
    final updatedTodo = Todo(
      id: originalTodo.id,
      projectId: originalTodo.projectId,
      title: titleController.text,
      startDate: startDate,
      endDate: endDate,
      isDone: originalTodo.isDone,
      subTasks: List.generate(
        subTaskControllers.length,
        (index) => SubTask(
          id: originalTodo.subTasks.length > index
              ? originalTodo.subTasks[index].id
              : UniqueKey().toString(),
          todoId: originalTodo.id,
          title: subTaskControllers[index].text,
          isDone: originalTodo.subTasks.length > index
              ? originalTodo.subTasks[index].isDone
              : false,
        ),
      ),
    );

    await updateTodoUseCase(updatedTodo);
  }
}