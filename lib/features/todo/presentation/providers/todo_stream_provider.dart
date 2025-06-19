import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/todo.dart';
import 'stream_todos_usecase_provider.dart';

final todoStreamProvider = StreamProvider.family<List<Todo>, String>((ref, projectId) {
  final usecase = ref.watch(streamTodosUseCaseProvider);
  return usecase.call(projectId);
});
