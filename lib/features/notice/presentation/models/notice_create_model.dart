import 'package:todomodu_app/features/notice/domain/entities/notice.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';

class NoticeCreateModel {
  final String projectId;
  final String title;
  final String content;
  final UserEntity author;
  final bool isSubmitting;
  final String? error;

  const NoticeCreateModel({
    required this.projectId,
    required this.author,
    this.title = '',
    this.content = '',
    this.isSubmitting = false,
    this.error,
  });

  NoticeCreateModel copyWith({
    String? projectId,
    String? title,
    String? content,
    UserEntity? author,
    bool? isSubmitting,
    String? error,
  }) {
    return NoticeCreateModel(
      projectId: projectId ?? this.projectId,
      author: author ?? this.author,
      title: title ?? this.title,
      content: content ?? this.content,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      error: error,
    );
  }

  @override
  String toString() {
    return 'NoticeCreateModel(projectId: $projectId, title: $title, content: $content, author: ${author.userId}, isSubmitting: $isSubmitting, error: $error)';
  }

  Notice toEntity({
    required String id,
    required DateTime createdAt,
    List<UserEntity> checkedUsers = const [],
  }) {
    return Notice(
      id: id,
      projectId: projectId,
      title: title,
      content: content,
      author: author,
      checkedUsers: checkedUsers,
      createdAt: createdAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoticeCreateModel &&
          runtimeType == other.runtimeType &&
          projectId == other.projectId &&
          title == other.title &&
          content == other.content &&
          author == other.author &&
          isSubmitting == other.isSubmitting &&
          error == other.error;

  @override
  int get hashCode =>
      projectId.hashCode ^
      title.hashCode ^
      content.hashCode ^
      author.hashCode ^
      isSubmitting.hashCode ^
      error.hashCode;
}
