import 'dart:ui';
import 'package:todomodu_app/features/todo/domain/entities/todo.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';

class Project {
  String id;
  String title;
  String description;
  DateTime startDate;
  DateTime endDate;
  UserEntity owner;
  List<UserEntity> members;
  List<Todo> todos;
  String invitationCode;
  bool isDone;
  Color color;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.owner,
    required this.members,
    required this.todos,
    required this.invitationCode,
    required this.isDone,
    required this.color,
  });
}
