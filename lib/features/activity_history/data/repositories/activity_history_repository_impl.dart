

import 'package:todomodu_app/features/activity_history/data/datasources/activity_history_datasource.dart';
import 'package:todomodu_app/features/activity_history/domain/entities/activity_history.dart';
import 'package:todomodu_app/features/activity_history/domain/repositories/activity_repository.dart';

class ActivityRepositoryImpl implements ActivityRepository {
  final ActivityHistoryDatasource _dataSource;

  ActivityRepositoryImpl({required ActivityHistoryDatasource dataSource}) : _dataSource = dataSource;

  @override
  Future<void> record(ActivityHistory activity) {
    return _dataSource.save(activity);
  }

  @override
  Future<List<ActivityHistory>> getByProject(String projectId) {
    return _dataSource.fetchByProjectId(projectId);
  }
}


