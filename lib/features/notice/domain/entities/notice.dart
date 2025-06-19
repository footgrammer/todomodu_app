import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';

class Notice {
  String id;
  String projectId;
  String title;
  String content;
  List<UserEntity> checkedUsers;
  DateTime createdAt;

  Notice({
    required this.id,
    required this.projectId,
    required this.title,
    required this.content,
    required this.checkedUsers,
    required this.createdAt,
  });

  Notice copyWith({
    String? id,
    String? projectId,
    String? title,
    String? content,
    List<UserEntity>? checkedUsers,
    DateTime? createdAt,
  }) {
    return Notice(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      title: title ?? this.title,
      content: content ?? this.content,
      checkedUsers: checkedUsers ?? this.checkedUsers,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
