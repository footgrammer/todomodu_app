import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

class Project {
  String id;
  String title;
  String description;
  Color color;
  DateTime startDate;
  DateTime endDate;
  // User owner;
  // List<User> members;
  // List<Todo> todos;
  String invitationCode;
  bool isDone;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.color,
    required this.startDate,
    required this.endDate,
    // required this.owner,
    // required this.members,
    // required this.todos,
    required this.invitationCode,
    required this.isDone,
  });

  Project.fromJson(Map<String, dynamic> map)
    : this(
        id: map['id'] ?? '',
        title: map['title'] ?? '',
        description: map['description'] ?? '',
        color: Color(map['color'] ?? 0xFFFFFFFF),
        startDate: (map['startDate'] as Timestamp).toDate(),
        endDate: (map['endDate'] as Timestamp).toDate(),
        // owner: map['owner'],
        // members: map['members'],
        // todos: map['todos'],
        invitationCode: map['invitationCode'] ?? '',
        isDone: map['isDone'] ?? false,
      );

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'color': color, // Color → int 저장
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
      // 'owner': owner,
      // 'members': members,
      // 'todos': todos,
      'invitationCode': invitationCode,
      'isDone': isDone,
    };
  }
}
