import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todomodu_app/features/todo/domain/entities/subtask.dart';

class Todo {
  final String id;
  final String projectId;
  final String title;
  final List<Subtask> subtasks;
  final DateTime startDate;
  final DateTime endDate;
  final bool isDone;

  const Todo({
    required this.id,
    required this.projectId,
    required this.title,
    required this.subtasks,
    required this.startDate,
    required this.endDate,
    required this.isDone,
  });

  Todo copyWith({
    String? id,
    String? projectId,
    String? title,
    List<Subtask>? subtasks,
    DateTime? startDate,
    DateTime? endDate,
    bool? isDone,
  }) {
    return Todo(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      title: title ?? this.title,
      subtasks: subtasks ?? this.subtasks,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isDone: isDone ?? this.isDone,

      // id: id,
      // title: map['title'] ?? '',
      // isDone: map['isDone'] ?? false,
      // projectId: map['projectId'] ?? '',
      // startDate: (map['startDate'] as Timestamp).toDate(),
      // endDate: (map['endDate'] as Timestamp).toDate(),
      // subtasks: [],
    );
  }
}
