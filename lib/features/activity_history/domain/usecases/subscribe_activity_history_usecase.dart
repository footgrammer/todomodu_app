import 'package:todomodu_app/features/activity_history/domain/entities/activity_history.dart';
import 'package:todomodu_app/features/activity_history/domain/repositories/activity_history_repository.dart';

class SubscribeActivityHistoryUsecase {
  final ActivityHistoryRepository _repository;

  SubscribeActivityHistoryUsecase(this._repository);

  Stream<List<ActivityHistory>> execute(String projectId) {
    return _repository.subscribe(projectId);
  }
}
