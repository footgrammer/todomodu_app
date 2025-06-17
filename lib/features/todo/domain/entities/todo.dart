import 'subtask.dart';

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
      'projectId': projectId,
      'title': title,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'isDone': isDone,
      'subtasks': subtasks.map((e) => e.toMap()).toList(),
    };
  }

  factory Todo.fromMap(String id, Map<String, dynamic> map) {
    return Todo(
      id: id,
      projectId: map['projectId'],
      title: map['title'],
      startDate: DateTime.parse(map['startDate']),
      endDate: DateTime.parse(map['endDate']),
      isDone: map['isDone'],
      subtasks: (map['subtasks'] as List<dynamic>)
          .map((e) => Subtask.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
