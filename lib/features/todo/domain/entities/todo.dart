import 'package:todomodu_app/features/todo/domain/entities/sub_task.dart';

class Todo {
  String id;
  String projectId;
  String title;
  List<SubTask> subTasks;
  DateTime startDate;
  DateTime endDate;

  Todo({
    required this.id,
    required this.projectId,
    required this.title,
    required this.subTasks,
    required this.startDate,
    required this.endDate,
  });
}