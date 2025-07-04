

import 'package:todomodu_app/features/activity_history/data/datasources/activity_history_datasource.dart';
import 'package:todomodu_app/features/activity_history/domain/entities/activity_history.dart';
import 'package:todomodu_app/features/activity_history/domain/repositories/activity_history_repository.dart';
import 'package:todomodu_app/shared/types/result.dart';

class ActivityHistoryRepositoryImpl implements ActivityHistoryRepository {
  final ActivityHistoryDatasource _dataSource;

  ActivityHistoryRepositoryImpl({required ActivityHistoryDatasource dataSource}) : _dataSource = dataSource;

  @override
  Future<Result<void>> record(ActivityHistory activity) {
    return _dataSource.save(activity);
  }

  @override
  Future<Result<List<ActivityHistory>>> getByProject(String projectId) {
    return _dataSource.fetchByProjectId(projectId);
  }
  
  @override
  Stream<List<ActivityHistory>> subscribe(String projectId) {
    return _dataSource.subscribe(projectId);
  }
}


