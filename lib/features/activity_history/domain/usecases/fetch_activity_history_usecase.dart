import 'package:todomodu_app/features/activity_history/domain/entities/activity_history.dart';
import 'package:todomodu_app/features/activity_history/domain/repositories/activity_history_repository.dart';
import 'package:todomodu_app/shared/types/result.dart';

class FetchActivityHistoryUsecase {
  final ActivityHistoryRepository repository;

  FetchActivityHistoryUsecase(this.repository);

  Future<Result<List<ActivityHistory>>> execute(String projectId) {
    return repository.getByProject(projectId);
  }
}
