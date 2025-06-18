import 'package:todomodu_app/features/notice/domain/entities/notice.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';

class NoticeCreateModel {
  final String projectId;
  final String title;
  final String content;
  final bool isSubmitting;
  final String? error;

  const NoticeCreateModel({
    required this.projectId,
    this.title = '',
    this.content = '',
    this.isSubmitting = false,
    this.error,
  });

  NoticeCreateModel copyWith({
    String? projectId,
    String? title,
    String? content,
    bool? isSubmitting,
    String? error,
  }) {
    return NoticeCreateModel(
      projectId: projectId ?? this.projectId,
      title: title ?? this.title,
      content: content ?? this.content,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      error: error,
    );
  }

  @override
  String toString() {
    return 'NoticeCreateModel(projectId: $projectId, title: $title, content: $content, isSubmitting: $isSubmitting, error: $error)';
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
          isSubmitting == other.isSubmitting &&
          error == other.error;

  @override
  int get hashCode =>
      projectId.hashCode ^
      title.hashCode ^
      content.hashCode ^
      isSubmitting.hashCode ^
      error.hashCode;
}
