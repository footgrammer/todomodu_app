import 'package:todomodu_app/features/activity_history/domain/entities/activity_history.dart';
import 'package:todomodu_app/shared/types/result.dart';

abstract interface class ActivityHistoryRepository {
  Future<Result<void>> record(ActivityHistory activity);
  Future<Result<List<ActivityHistory>>> getByProject(String projectId);
  Stream<List<ActivityHistory>> subscribe(String projectId);
}
