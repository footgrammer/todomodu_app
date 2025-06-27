import 'package:todomodu_app/features/todo/domain/entities/subtask.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';

class SubtaskDto {
  final String id;
  final String projectId;
  final String todoId;
  final String title;
  final bool isDone;
  final List<String>? assigneeId;

  const SubtaskDto({
    required this.id,
    required this.projectId,
    required this.todoId,
    required this.title,
    required this.isDone,
    this.assigneeId,
  });

  /// Firestore → Dto
  factory SubtaskDto.fromJson(Map<String, dynamic> json, {required String id}) {
    return SubtaskDto(
      id: id,
      projectId: json['projectId'] as String,
      todoId: json['todoId'] as String,
      title: json['title'] as String,
      isDone: json['isDone'] as bool,
      assigneeId: (json['assigneeId'] is List)
        ? (json['assigneeId'] as List).map((e) => e.toString()).toList()
        : null,
    );
  }

  /// Dto → Firestore
  Map<String, dynamic> toJson() {
    return {
      'projectId': projectId,
      'todoId': todoId,
      'title': title,
      'isDone': isDone,
      'assigneeId': assigneeId ?? [],
    };
  }

  /// Entity → Dto
  factory SubtaskDto.fromEntity(Subtask entity) {
    return SubtaskDto(
      id: entity.id,
      projectId: entity.projectId,
      todoId: entity.todoId,
      title: entity.title,
      isDone: entity.isDone,
      assigneeId: entity.assignee?.map((e) => e.userId).toList(),
    );
  }

  /// Dto → Entity (nullable assignee 주입 필요)
  Subtask toEntity({List<UserEntity>? assignee}) {
    return Subtask(
      id: id,
      title: title,
      isDone: isDone,
      todoId: todoId,
      projectId: projectId,
      assignee: assignee,
    );
  }

  /// copyWith
  SubtaskDto copyWith({
    String? id,
    String? projectId,
    String? todoId,
    String? title,
    bool? isDone,
    List<String>? assigneeId,
  }) {
    return SubtaskDto(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      todoId: todoId ?? this.todoId,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      assigneeId: assigneeId ?? this.assigneeId,
    );
  }
}
