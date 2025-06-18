import 'package:todomodu_app/features/user/domain/models/user_entity.dart';

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
}
