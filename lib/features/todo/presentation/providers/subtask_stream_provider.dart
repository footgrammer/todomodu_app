import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/subtask.dart';
import 'subtask_repository_provider.dart';

final subtaskStreamProvider =
    StreamProvider.family<List<Subtask>, (String, String)>((ref, params) {
  final (projectId, todoId) = params;
  final repo = ref.watch(subtaskRepositoryProvider);
  return repo.streamSubtasks(projectId: projectId, todoId: todoId);
});
