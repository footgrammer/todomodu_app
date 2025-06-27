import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';

class Subtask {
  final String id;
  final String title;
  final bool isDone;
  final String todoId;
  final String projectId;
  final List<UserEntity>? assignee;

  const Subtask({
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
    List<UserEntity>? assignee,
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
}
