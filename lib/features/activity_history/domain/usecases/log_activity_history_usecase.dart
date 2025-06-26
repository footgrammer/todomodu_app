import 'package:todomodu_app/features/activity_history/domain/entities/activity_history.dart';
import 'package:todomodu_app/features/activity_history/domain/repositories/activity_history_repository.dart';
import 'package:todomodu_app/shared/types/result.dart';

class LogActivityHistoryUsecase {
  final ActivityHistoryRepository _activityHistoryRepository;

  LogActivityHistoryUsecase({
    required ActivityHistoryRepository activityHistoryRepository,
  }) : _activityHistoryRepository = activityHistoryRepository;

  Future<Result<void>> execute(ActivityHistory activity) {
    return _activityHistoryRepository.record(activity);
  }
}
