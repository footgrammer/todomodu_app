import 'package:todomodu_app/features/todo/domain/entities/todo.dart';
import 'package:todomodu_app/features/user/domain/models/user_entity.dart';

class Project {
  String id;
  String title;
  String description;
  DateTime startTime;
  DateTime endTime;
  UserEntity owner;
  List<UserEntity> members;
  List<Todo> todos;
  String inviteCode;
  bool isDone;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.owner,
    required this.members,
    required this.todos,
    required this.inviteCode,
    required this.isDone,
  });
}