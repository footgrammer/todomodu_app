import 'package:todomodu_app/features/activity_history/domain/entities/activity_history.dart';

abstract class ActivityRepository {
  Future<void> record(ActivityHistory activity);
  Future<List<ActivityHistory>> getByProject(String projectId);
}