import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/usecases/toggle_subtask_done_usecase.dart';
import 'subtask_repository_provider.dart';

final toggleSubtaskDoneUseCaseProvider = Provider<ToggleSubtaskDoneUseCase>((ref) {
  final repository = ref.watch(subtaskRepositoryProvider);
  return ToggleSubtaskDoneUseCase(repository);
});
