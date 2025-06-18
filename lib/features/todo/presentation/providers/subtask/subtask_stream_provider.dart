import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/todo/presentation/providers/subtask/subtask_providers.dart';
import '../../../domain/entities/subtask.dart';

final subtaskStreamProvider = StreamProvider.family<List<Subtask>, (String, String)>((ref, tuple) {
  final (projectId, todoId) = tuple;
  final repo = ref.watch(subtaskRepositoryProvider);
  return repo.streamSubtasks(projectId, todoId);
});
