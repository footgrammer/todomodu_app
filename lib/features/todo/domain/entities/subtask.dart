import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';

class Subtask {
  String id;
  String todoId;
  String title;
  bool isDone;
  UserEntity? assignee;
  Subtask({
    required this.id,
    required this.todoId,
    required this.title,
    required this.isDone,
    required this.assignee,
  });
}