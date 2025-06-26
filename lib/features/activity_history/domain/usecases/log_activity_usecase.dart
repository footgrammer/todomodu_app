import 'package:todomodu_app/features/activity_history/domain/entities/activity_history.dart';
import 'package:todomodu_app/features/activity_history/domain/repositories/activity_history_repository.dart';
import 'package:todomodu_app/shared/types/result.dart';

class LogActivityUsecase {
  final ActivityHistoryRepository _activityHistoryRepository;

  LogActivityUsecase({
    required ActivityHistoryRepository activityHistoryRepository,
  }) : _activityHistoryRepository = activityHistoryRepository;

  Future<Result<void>> execute(ActivityHistory activity) {
    return _activityHistoryRepository.record(activity);
  }
}
