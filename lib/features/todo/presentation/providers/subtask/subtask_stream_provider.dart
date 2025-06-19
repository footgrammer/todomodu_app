import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/todo/domain/entities/subtask.dart';
import 'subtask_repository_provider.dart';

final subtaskStreamProvider = StreamProvider.family<List<Subtask>, (String, String)>((ref, args) {
  final (projectId, todoId) = args;
  final repo = ref.watch(subtaskRepositoryProvider);
  return repo.streamSubtasks(projectId, todoId);
});
