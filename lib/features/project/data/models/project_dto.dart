import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/features/todo/domain/entities/todo.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';

class ProjectDto {
  String id;
  String title;
  String description;
  DateTime startTime;
  DateTime endTime;
  String ownerId;
  // List<String> memberIds;
  // List<String> todoIds;
  String inviteCode;
  bool isDone;

  ProjectDto({
    required this.id,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.ownerId,
    // required this.memberIds,
    // required this.todoIds,
    required this.inviteCode,
    required this.isDone,
  });

  factory ProjectDto.fromJson(Map<String, dynamic> json) {
    return ProjectDto(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      ownerId: json['ownerId'] as String,
      // memberIds: List<String>.from(json['memberIds'] ?? []),
      // todoIds: List<String>.from(json['todoIds'] ?? []),
      inviteCode: json['inviteCode'] as String,
      isDone: json['isDone'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'ownerId': ownerId,
      // 'memberIds': memberIds,
      // 'todoIds': todoIds,
      'inviteCode': inviteCode,
      'isDone': isDone,
    };
  }

  factory ProjectDto.fromEntity(Project entity) {
    return ProjectDto(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      startTime: entity.startTime,
      endTime: entity.endTime,
      ownerId: entity.owner.id,
      // memberIds: entity.members.map((e) => e.id).toList(),
      // todoIds: entity.todos.map((e) => e.id).toList(),
      inviteCode: entity.inviteCode,
      isDone: entity.isDone,
    );
  }

  Project toEntity({
    required UserEntity owner,
    required List<UserEntity> members,
    required List<Todo> todos,
  }) {
    return Project(
      id: id,
      title: title,
      description: description,
      startTime: startTime,
      endTime: endTime,
      owner: owner,
      members: members,
      todos: todos,
      inviteCode: inviteCode,
      isDone: isDone,
    );
  }
}
