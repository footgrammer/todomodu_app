



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/activity_history/data/datasources/activity_history_datasource_impl.dart';
import 'package:todomodu_app/features/activity_history/data/repositories/activity_history_repository_impl.dart';
import 'package:todomodu_app/features/activity_history/domain/entities/activity_history.dart';
import 'package:todomodu_app/features/activity_history/domain/usecases/fetch_activity_history_usecase.dart';
import 'package:todomodu_app/features/activity_history/domain/usecases/log_activity_history_usecase.dart';
import 'package:todomodu_app/features/activity_history/presentation/viewmodels/activity_history_list_viewmodel.dart';

final _activityHistoryDataSourceProvider = Provider<ActivityHistoryDatasourceImpl>((ref) {
  return ActivityHistoryDatasourceImpl(firestore: FirebaseFirestore.instance);
});

final activityHistoryRepositoryProvider = Provider<ActivityHistoryRepositoryImpl>((ref) {
  return ActivityHistoryRepositoryImpl(
    dataSource: ref.watch(_activityHistoryDataSourceProvider),
  );
});



final logActivityHistoryUsecaseProvider = Provider<LogActivityHistoryUsecase>((ref) {
  return LogActivityHistoryUsecase(
    activityHistoryRepository: ref.watch(activityHistoryRepositoryProvider),
  );
});

final fetchActivityHistoryUsecaseProvider = Provider((ref) {
  final repository = ref.watch(activityHistoryRepositoryProvider);
  return FetchActivityHistoryUsecase(repository);
});

final activityHistoryListViewModelProvider =
    AsyncNotifierProvider.family<ActivityHistoryListViewModel, List<ActivityHistory>, String>(
  ActivityHistoryListViewModel.new,
);






