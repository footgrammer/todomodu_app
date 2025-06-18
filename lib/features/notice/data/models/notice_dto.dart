import 'package:todomodu_app/features/notice/domain/entities/notice.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';

class NoticeDto {
  String id;
  String projectId;
  String title;
  String content;
  List<String> checkedUsers;
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
      'id': id,
      'projectId': projectId,
      'title': title,
      'content': content,
      'checkedUsers': checkedUsers,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory NoticeDto.fromJson(Map<String, dynamic> map) {
    return NoticeDto(
      id: map['id'] as String,
      projectId: map['projectId'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      checkedUsers: List<String>.from(map['checkedUsers'] ?? []),
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  /// `checkedUsers`에는 userId만 있으므로,
  /// 실제 UserEntity 리스트는 외부에서 주입받아야 함
  Notice toEntity({required List<UserEntity> fullCheckedUsers}) {
    return Notice(
      id: id,
      projectId: projectId,
      title: title,
      content: content,
      checkedUsers: fullCheckedUsers,
      createdAt: createdAt,
    );
  }

  factory NoticeDto.fromEntity(Notice entity) {
    return NoticeDto(
      id: entity.id,
      projectId: entity.projectId,
      title: entity.title,
      content: entity.content,
      checkedUsers: entity.checkedUsers.map((e) => e.userId).toList(),
      createdAt: entity.createdAt,
    );
  }

  NoticeDto copyWith({
    String? id,
    String? projectId,
    String? title,
    String? content,
    List<String>? checkedUsers,
    DateTime? createdAt,
  }) {
    return NoticeDto(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      title: title ?? this.title,
      content: content ?? this.content,
      checkedUsers: checkedUsers ?? List.from(this.checkedUsers),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
