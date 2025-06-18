import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/features/todo/domain/entities/todo.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';

class ProjectDto {
  String id;
  String title;
  String description;
  DateTime startDate;
  DateTime endDate;
  String ownerId;
  // List<String> memberIds;
  // List<String> todoIds;
  String invitationCode;
  bool isDone;

  ProjectDto({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.ownerId,
    // required this.memberIds,
    // required this.todoIds,
    required this.invitationCode,
    required this.isDone,
  });

  factory ProjectDto.fromJson(Map<String, dynamic> json) {
    return ProjectDto(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      // Timestamp → DateTime
      startDate: (json['startDate'] as Timestamp).toDate(),
      endDate: (json['endDate'] as Timestamp).toDate(),
      ownerId: json['ownerId'] as String,
      // memberIds: List<String>.from(json['memberIds'] ?? []),
      // todoIds:   List<String>.from(json['todoIds']   ?? []),
      invitationCode: json['invitationCode'] as String,
      isDone: json['isDone'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      // DateTime → Timestamp
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
      'ownerId': ownerId,
      // 'memberIds': memberIds,
      // 'todoIds':   todoIds,
      'inviteCode': invitationCode,
      'isDone': isDone,
    };
  }

  factory ProjectDto.fromEntity(Project entity) {
    return ProjectDto(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      startDate: entity.startDate,
      endDate: entity.endDate,
      ownerId: entity.owner.userId,
      // memberIds: entity.members.map((e) => e.id).toList(),
      // todoIds:   entity.todos.map((e) => e.id).toList(),
      invitationCode: entity.invitationCode,
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
      startDate: startDate,
      endDate: endDate,
      owner: owner,
      members: members,
      todos: todos,
      invitationCode: invitationCode,
      isDone: isDone,
    );
  }
}
