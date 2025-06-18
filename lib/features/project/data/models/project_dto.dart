<<<<<<< HEAD

=======
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/features/todo/data/models/todo_dto.dart';
import 'package:todomodu_app/features/user/data/models/user_dto.dart';
import 'package:todomodu_app/shared/utils/parse_date.dart';

class ProjectDto {
  String id;
  String title;
  String description;
  Color color;
  DateTime startDate;
  DateTime endDate;
  UserDto owner;
  List<UserDto> members;
  List<TodoDto> todos;
  String invitationCode;
  bool isDone;

  ProjectDto({
    required this.id,
    required this.title,
    required this.description,
    required this.color,
    required this.startDate,
    required this.endDate,
    required this.owner,
    required this.members,
    required this.todos,
    required this.invitationCode,
    required this.isDone,
  });

  ProjectDto.fromJson(Map<String, dynamic> map)
    : this(
        id: map['id'] ?? '',
        title: map['title'] ?? '',
        description: map['description'] ?? '',
        color: Color(map['color'] ?? Color(0xFFFFFFFF)),
        startDate: parseDate(map['startDate']),
        endDate: parseDate(map['endDate']),
        owner: map['owner'],
        members: map['members'],
        todos: map['todos'],
        invitationCode: map['invitationCode'] ?? '',
        isDone: map['isDone'] ?? false,
      );

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'color': color.value, // Color → int 저장
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
      'owner': owner,
      'members': members,
      'todos': todos,
      'invitationCode': invitationCode,
      'isDone': isDone,
    };
  }

  Project toEntity() {
    return Project(
      id: id,
      title: title,
      description: description,
      color: color,
      startDate: startDate,
      endDate: endDate,
      owner: owner.toEntity(),
      members: members.map((userDto) => userDto.toEntity()).toList(),
      todos: todos.map((todoDto) => todoDto.toEntity()).toList(),
      invitationCode: invitationCode,
      isDone: isDone,
    );
  }
}
>>>>>>> 61c9c2a (feat : change projectState and make usecases file)
