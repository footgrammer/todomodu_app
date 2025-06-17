import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/usecases/toggle_subtask_done_usecase.dart';
import 'todo_repository_provider.dart';

final toggleSubtaskDoneUseCaseProvider = Provider<ToggleSubtaskDoneUseCase>((ref) {
  final repository = ref.watch(todoRepositoryProvider);
  return ToggleSubtaskDoneUseCase(repository);
});
