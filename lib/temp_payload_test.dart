// lib/temp_payload_test.dart
import 'package:todomodu_app/features/activity_history/domain/models/activity_history_payload.dart';

void triggerBuild() {
  final _ = ActivityHistoryPayload.taskAdded(
    taskId: 't1',
    title: 'test',
    creatorId: 'u1',
  );
}

