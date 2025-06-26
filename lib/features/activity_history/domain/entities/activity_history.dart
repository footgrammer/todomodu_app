import 'package:todomodu_app/features/activity_history/domain/models/activity_history_payload.dart';

class ActivityHistory {
  /// Firestore 도큐먼트 ID (nullable)
  final String? id;

  final String projectId;
  final DateTime createdAt;
  final ActivityHistoryPayload payload;

  ActivityHistory({
    this.id, // 🔧 이제 optional
    required this.projectId,
    required this.createdAt,
    required this.payload,
  });
}
