import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';
import 'package:todomodu_app/features/todo/domain/entities/todo.dart';
import 'package:todomodu_app/features/todo/presentation/providers/todo_repository_provider.dart';


final todoStreamByIdProvider = StreamProvider.family<Todo, Tuple2<String, String>>((ref, params) {
  final repo = ref.watch(todoRepositoryProvider);
  return repo.streamTodoById(params.item1, params.item2);
});