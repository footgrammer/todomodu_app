import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/usecases/toggle_subtask_done_usecase.dart';
import '../providers/toggle_subtask_done_usecase_provider.dart';

class SubtaskViewModel {
  final ToggleSubtaskDoneUseCase toggleUseCase;

  SubtaskViewModel(this.toggleUseCase);

  Future<void> toggle({
    required String projectId,
    required String todoId,
    required String subtaskId,
    required bool isDone,
  }) async {
    await toggleUseCase.call(
      projectId: projectId,
      todoId: todoId,
      subtaskId: subtaskId,
      isDone: isDone,
    );
  }
}

final subtaskViewModelProvider = Provider<SubtaskViewModel>((ref) {
  final useCase = ref.watch(toggleSubtaskDoneUseCaseProvider);
  return SubtaskViewModel(useCase);
});
