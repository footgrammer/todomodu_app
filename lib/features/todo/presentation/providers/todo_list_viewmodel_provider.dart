import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/todo_list_viewmodel.dart';
import 'stream_todos_usecase_provider.dart';

final todoListViewModelProvider = Provider<TodoListViewModel>((ref) {
  final streamTodosUseCase = ref.watch(streamTodosUseCaseProvider);
  return TodoListViewModel(streamTodosUseCase);
});