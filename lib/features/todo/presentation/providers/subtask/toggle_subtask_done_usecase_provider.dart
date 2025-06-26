import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/todo/presentation/providers/subtask/subtask_provider.dart';
import '../../../application/usecases/toggle_subtask_done_usecase.dart';

final toggleSubtaskDoneUseCaseProvider = Provider<ToggleSubtaskDoneUseCase>((ref) {
  final repository = ref.watch(subtaskRepositoryProvider);
  return ToggleSubtaskDoneUseCase(repository);
});
