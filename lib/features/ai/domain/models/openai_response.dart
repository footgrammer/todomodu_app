// To parse this JSON data, do
//
//     final openaiResponse = openaiResponseFromJson(jsonString);

import 'dart:convert';

OpenaiResponse openaiResponseFromJson(String str) =>
    OpenaiResponse.fromJson(json.decode(str));

String openaiResponseToJson(OpenaiResponse data) => json.encode(data.toJson());

class OpenaiResponse {
  final String projectTitle;
  final String projectDescription;
  final String projectStartDate;
  final String projectEndDate;
  final List<Todo> todos;

  OpenaiResponse({
    required this.projectTitle,
    required this.projectDescription,
    required this.projectStartDate,
    required this.projectEndDate,
    required this.todos,
  });

  OpenaiResponse copyWith({
    String? projectTitle,
    String? projectDescription,
    String? projectStartDate,
    String? projectEndDate,
    List<Todo>? todos,
  }) => OpenaiResponse(
    projectTitle: projectTitle ?? this.projectTitle,
    projectDescription: projectDescription ?? this.projectDescription,
    projectStartDate: projectStartDate ?? this.projectStartDate,
    projectEndDate: projectEndDate ?? this.projectEndDate,
    todos: todos ?? this.todos,
  );

  factory OpenaiResponse.fromJson(Map<String, dynamic> json) => OpenaiResponse(
    projectTitle: json["project_title"],
    projectDescription: json["project_description"],
    projectStartDate: json["project_start_date"],
    projectEndDate: json["project_end_date"],
    todos: List<Todo>.from(json["todos"].map((x) => Todo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "project_title": projectTitle,
    "project_description": projectDescription,
    "project_start_date": projectStartDate,
    "project_end_date": projectEndDate,
    "todos": List<dynamic>.from(todos.map((x) => x.toJson())),
  };
}

class Todo {
  final String todoTitle;
  final String todoStartDate;
  final String todoEndDate;
  final List<String> subtasks;

  Todo({
    required this.todoTitle,
    required this.todoStartDate,
    required this.todoEndDate,
    required this.subtasks,
  });

  Todo copyWith({
    String? todoTitle,
    String? todoStartDate,
    String? todoEndDate,
    List<String>? subtasks,
  }) => Todo(
    todoTitle: todoTitle ?? this.todoTitle,
    todoStartDate: todoStartDate ?? this.todoStartDate,
    todoEndDate: todoEndDate ?? this.todoEndDate,
    subtasks: subtasks ?? this.subtasks,
  );

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    todoTitle: json["todo_title"],
    todoStartDate: json["todo_start_date"],
    todoEndDate: json["todo_end_date"],
    subtasks: List<String>.from(json["sub_tasks"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "todo_title": todoTitle,
    "todo_start_date": todoStartDate,
    "todo_end_date": todoEndDate,
    "sub_tasks": List<dynamic>.from(subtasks.map((x) => x)),
  };
}
