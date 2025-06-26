import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/todo/domain/entities/todo.dart';
import 'stream_todos_usecase_provider.dart';

final todoStreamProvider = StreamProvider.family<List<Todo>, String>((ref, projectId) {
  final usecase = ref.watch(streamTodosUseCaseProvider);
  return usecase(projectId);
});
