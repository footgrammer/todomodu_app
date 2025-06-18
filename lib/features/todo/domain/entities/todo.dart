import 'package:todomodu_app/features/todo/domain/entities/subtask.dart';

class Todo {
  final String id;
  final String projectId;
  final String title;
  final List<Subtask> subtasks;
  final DateTime startDate;
  final DateTime endDate;
  final bool isDone;

  Todo({
    required this.id,
    required this.projectId,
    required this.title,
    required this.subtasks,
    required this.startDate,
    required this.endDate,
    required this.isDone,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isDone': isDone,
      'projectId': projectId,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    };
  }

  factory Todo.fromMap(String id, Map<String, dynamic> map) {
    return Todo(
      id: id,
      title: map['title'] ?? '',
      isDone: map['isDone'] ?? false,
      projectId: map['projectId'] ?? '',
      startDate: DateTime.parse(map['startDate']),
      endDate: DateTime.parse(map['endDate']),
      subtasks: [],
    );
  }
}
