import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/usecases/toggle_subtask_done_usecase.dart';
import 'todo_repository_provider.dart';

final toggleSubTaskDoneUseCaseProvider = Provider<ToggleSubTaskDoneUseCase>((ref) {
  final repository = ref.watch(todoRepositoryProvider);
  return ToggleSubTaskDoneUseCase(repository);
});
