import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';

class SubTask {
  String id;
  String todoId;
  String title;
  bool isDone;
  // UserEntity assignee;
  SubTask({
    required this.id,
    required this.todoId,
    required this.title,
    required this.isDone,
    // required this.assignee,
  });

    SubTask copyWith({
    String? id,
    String? todoId,
    String? title,
    bool? isDone,
  }) {
    return SubTask(
      id: id ?? this.id,
      todoId: todoId ?? this.todoId,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }
  
}