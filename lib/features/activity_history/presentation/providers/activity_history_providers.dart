



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/activity_history/data/datasources/activity_history_datasource_impl.dart';
import 'package:todomodu_app/features/activity_history/data/repositories/activity_history_repository_impl.dart';
import 'package:todomodu_app/features/activity_history/domain/usecases/log_activity_history_usecase.dart';

final _activityHistoryDataSourceProvider = Provider<ActivityHistoryDatasourceImpl>((ref) {
  return ActivityHistoryDatasourceImpl(firestore: FirebaseFirestore.instance);
});

final noticeRepositoryProvider = Provider<ActivityHistoryRepositoryImpl>((ref) {
  return ActivityHistoryRepositoryImpl(
    dataSource: ref.watch(_activityHistoryDataSourceProvider),
  );
});



final logActivityHistoryUsecaseProvider = Provider<LogActivityHistoryUsecase>((ref) {
  return LogActivityHistoryUsecase(
    activityHistoryRepository: ref.watch(noticeRepositoryProvider),
  );
});
