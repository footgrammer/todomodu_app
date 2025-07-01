import 'package:todomodu_app/features/activity_history/domain/entities/activity_history.dart';
import 'package:todomodu_app/shared/types/result.dart';

abstract interface class ActivityHistoryDatasource {
  Future<Result<void>> save(ActivityHistory activity);
  Future<Result<List<ActivityHistory>>> fetchByProjectId(String projectId);
  Stream<List<ActivityHistory>> subscribe(String projectId);
}