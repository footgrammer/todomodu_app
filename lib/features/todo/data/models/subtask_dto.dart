import 'package:todomodu_app/features/todo/domain/entities/subtask.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';

class SubtaskDto {
  final String id;
  final String todoId;
  final String title;
  final bool isDone;
  final String? assigneeId; // nullable 처리

  const SubtaskDto({
    required this.id,
    required this.todoId,
    required this.title,
    required this.isDone,
    this.assigneeId,
  });

  /// Firestore → Dto
  factory SubtaskDto.fromJson(Map<String, dynamic> json, {required String id}) {
    return SubtaskDto(
      id: id,
      todoId: json['todoId'] as String,
      title: json['title'] as String,
      isDone: json['isDone'] as bool,
      assigneeId: json['assigneeId'] as String?,
    );
  }

  /// Dto → Firestore
  Map<String, dynamic> toJson() {
    return {
      'todoId': todoId,
      'title': title,
      'isDone': isDone,
      if (assigneeId != null) 'assigneeId': assigneeId,
    };
  }

  /// Entity → Dto
  factory SubtaskDto.fromEntity(Subtask entity) {
    return SubtaskDto(
      id: entity.id,
      todoId: entity.todoId,
      title: entity.title,
      isDone: entity.isDone,
      assigneeId: entity.assignee?.id,
    );
  }

  /// Dto → Entity (nullable assignee 주입 필요)
  Subtask toEntity({UserEntity? assignee}) {
    return Subtask(
      id: id,
      todoId: todoId,
      title: title,
      isDone: isDone,
      assignee: assignee,
    );
  }

  /// copyWith
  SubtaskDto copyWith({
    String? id,
    String? todoId,
    String? title,
    bool? isDone,
    String? assigneeId,
  }) {
    return SubtaskDto(
      id: id ?? this.id,
      todoId: todoId ?? this.todoId,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      assigneeId: assigneeId ?? this.assigneeId,
    );
  }
}
