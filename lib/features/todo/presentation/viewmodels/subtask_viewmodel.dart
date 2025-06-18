import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/subtask.dart';
import '../../domain/repositories/subtask_repository.dart';
import '../providers/subtask_repository_provider.dart';

class SubtaskViewModel {
  final SubtaskRepository repo;

  SubtaskViewModel(this.repo);

  Future<void> create(Subtask subtask) async {
    await repo.createSubtask(subtask);
  }

  Future<void> toggle({
    required String projectId,
    required String subtaskId,
    required bool isDone,
  }) async {
    await repo.toggleDone(
      projectId: projectId,
      subtaskId: subtaskId,
      isDone: isDone,
    );
  }

  Future<void> update(Subtask subtask) async {
    await repo.updateSubtask(subtask);
  }

  Future<void> delete({
    required String projectId,
    required String subtaskId,
  }) async {
    await repo.deleteSubtask(
      projectId: projectId,
      subtaskId: subtaskId,
    );
  }
}

final subtaskViewModelProvider = Provider<SubtaskViewModel>((ref) {
  final repo = ref.watch(subtaskRepositoryProvider);
  return SubtaskViewModel(repo);
});
