import 'package:todomodu_app/features/notice/domain/entities/notice.dart';
import 'package:todomodu_app/features/user/data/models/user_dto.dart';

class NoticeDto {
  String id;
  String projectId;
  String title;
  String content;
  List<UserDto> checkedUsers;
  DateTime createdAt;

  NoticeDto({
    required this.id,
    required this.projectId,
    required this.title,
    required this.content,
    required this.checkedUsers,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'projectId' : projectId,
      'title' : title,
      'content' : content,
      'checkedUsers' : checkedUsers.map((e) => e.toJson()).toList(),
      'createdAt' : createdAt,
    };
  }

  Notice toEntity() {
    return Notice(
      id: id,
      projectId: projectId,
      title: title,
      content: content,
      checkedUsers: checkedUsers.map((e) => e.toEntity()).toList(),
      createdAt: createdAt,
    );
  }

  factory NoticeDto.fromEntity(Notice entity) {
    return NoticeDto(
      id: entity.id,
      projectId: entity.projectId,
      title: entity.title,
      content: entity.content,
      checkedUsers:
          entity.checkedUsers.map((e) => UserDto.fromEntity(e)).toList(),
      createdAt: entity.createdAt,
    );
  }
}
