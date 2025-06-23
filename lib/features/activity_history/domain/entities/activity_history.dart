// lib/features/timeline/domain/entities/activity_history.dart


import 'package:todomodu_app/features/activity_history/domain/models/activity_history_payload.dart';

/// 타임라인 이벤트의 고유 ID와 페이로드를 감싸는 엔티티
class ActivityHistory {
  /// Firestore 도큐먼트 ID
  final String id;
  
  final String projectId;

  final DateTime createdAt;

  final ActivityHistoryPayload payload;

  ActivityHistory({
    required this.id,
    required this.payload,
    required this.projectId,
    required this.createdAt,
  });
}
