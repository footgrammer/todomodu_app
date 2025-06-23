import 'package:todomodu_app/features/activity_history/domain/entities/activity_history.dart';

abstract interface class ActivityHistoryDatasource {
  Future<void> save(ActivityHistory activity);
  Future<List<ActivityHistory>> fetchByProjectId(String projectId);
}