import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/subtask.dart';
import 'subtask_repository_provider.dart';

final subtaskStreamProvider = StreamProvider.family<List<Subtask>, (String, String)>((ref, tuple) {
  final (projectId, todoId) = tuple;
  final repo = ref.watch(subtaskRepositoryProvider);
  return repo.streamSubtasks(projectId, todoId);
});
