import 'package:todomodu_app/features/todo/domain/entities/subtask.dart';

class Todo {
  String id;
  String projectId;
  String title;
  List<Subtask> subTasks;
  DateTime startDate;
  DateTime endDate;
  bool isDone;

  Todo({
    required this.id,
    required this.projectId,
    required this.title,
    required this.subTasks,
    required this.startDate,
    required this.endDate,
    required this.isDone,
  });
}