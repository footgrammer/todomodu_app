import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todomodu_app/features/activity_history/domain/entities/activity_history.dart';
import 'package:todomodu_app/features/activity_history/domain/models/activity_history_payload.dart';

class ActivityHistoryDto {
  final String id;
  final String projectId;
  final DateTime createdAt;
  final ActivityHistoryPayload payload;

  ActivityHistoryDto({
    required this.id,
    required this.projectId,
    required this.createdAt,
    required this.payload,
  });

  factory ActivityHistoryDto.fromEntity(ActivityHistory entity) {
    return ActivityHistoryDto(
      id: entity.id,
      projectId: entity.projectId,
      createdAt: entity.createdAt,
      payload: entity.payload,
    );
  }

  ActivityHistory toEntity() {
    return ActivityHistory(
      id: id,
      projectId: projectId,
      createdAt: createdAt,
      payload: payload,
    );
  }

  factory ActivityHistoryDto.fromJson(Map<String, dynamic> json, String id) {
    return ActivityHistoryDto(
      id: id,
      projectId: json['projectId'] as String,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      payload: ActivityHistoryPayload.fromJson(json['payload'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'projectId': projectId,
      'createdAt': Timestamp.fromDate(createdAt),
      'payload': payload.toJson(),
    };
  }
}
