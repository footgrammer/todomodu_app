import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/todo.dart';
import '../viewmodels/edit_todo_viewmodel.dart';
import 'update_todo_usecase_provider.dart';

final editTodoViewModelProvider = Provider.family<EditTodoViewModel, Todo>((ref, todo) {
  final updateTodoUseCase = ref.watch(updateTodoUseCaseProvider);
  return EditTodoViewModel.create(
    todo: todo,
    updateTodoUseCase: updateTodoUseCase,
  );
});