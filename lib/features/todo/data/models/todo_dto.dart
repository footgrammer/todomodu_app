import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todomodu_app/features/todo/domain/entities/subtask.dart';
import 'package:todomodu_app/features/todo/domain/entities/todo.dart';

class TodoDto {
  final String id;
  final String projectId;
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final bool isDone;

  // DTO에는 subTasks는 포함하지 않음 (별도 subcollection으로 관리)
  const TodoDto({
    required this.id,
    required this.projectId,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.isDone,
  });

  /// fromJson (Firestore용)
  factory TodoDto.fromJson(Map<String, dynamic> json, {required String id}) {
    return TodoDto(
      id: id,
      projectId: json['projectId'] as String,
      title: json['title'] as String,
      startDate: (json['startDate'] as Timestamp).toDate(),
      endDate: (json['endDate'] as Timestamp).toDate(),
      isDone: json['isDone'] as bool,
    );
  }

  /// toJson (Firestore 저장용)
  Map<String, dynamic> toJson() {
    return {
      'projectId': projectId,
      'title': title,
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
      'isDone': isDone,
    };
  }

  /// fromEntity (Domain → Dto)
  factory TodoDto.fromEntity(Todo entity) {
    return TodoDto(
      id: entity.id,
      projectId: entity.projectId,
      title: entity.title,
      startDate: entity.startDate,
      endDate: entity.endDate,
      isDone: entity.isDone,
    );
  }

  /// toEntity (Dto → Domain)
  Todo toEntity({List<Subtask> subTasks = const []}) {
    return Todo(
      id: id,
      projectId: projectId,
      title: title,
      startDate: startDate,
      endDate: endDate,
      isDone: isDone,
      subtasks: subTasks, // 나중에 subtasks 따로 fetch해서 연결
    );
  }

  TodoDto copyWith({
    String? id,
    String? projectId,
    String? title,
    DateTime? startDate,
    DateTime? endDate,
    bool? isDone,
  }) {
    return TodoDto(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      title: title ?? this.title,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isDone: isDone ?? this.isDone,
    );
  }
}
