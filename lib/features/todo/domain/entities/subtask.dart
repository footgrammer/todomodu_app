import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';

class Subtask {
  final String id;
  final String title;
  final bool isDone;
  final String todoId;
  final String projectId;
  final UserEntity? assignee;

  Subtask({
    required this.id,
    required this.title,
    required this.isDone,
    required this.todoId,
    required this.projectId,
    this.assignee,
  });

  Subtask copyWith({
    String? id,
    String? title,
    bool? isDone,
    String? todoId,
    String? projectId,
    UserEntity? assignee,
  }) {
    return Subtask(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      todoId: todoId ?? this.todoId,
      projectId: projectId ?? this.projectId,
      assignee: assignee ?? this.assignee,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isDone': isDone,
      'todoId': todoId,
      'projectId': projectId,
      'assigneeId': assignee?.userId,
    };
  }

  factory Subtask.fromMap(Map<String, dynamic> map) {
    return Subtask(
      id: map['id'] as String? ?? '',
      title: map['title'] as String? ?? '',
      isDone: map['isDone'] as bool? ?? false,
      todoId: map['todoId'] as String? ?? '',
      projectId: map['projectId'] as String? ?? '',
      assignee: null,
    );
  }
}
