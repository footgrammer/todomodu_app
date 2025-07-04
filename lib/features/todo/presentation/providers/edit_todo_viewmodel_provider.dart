import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/user/presentation/providers/user_providers.dart';
import '../../domain/entities/todo.dart';
import '../viewmodels/edit_todo_viewmodel.dart';
import '../states/edit_todo_state.dart';
import 'update_todo_usecase_provider.dart';

final editTodoViewModelProvider =
    StateNotifierProvider.autoDispose.family<EditTodoViewModel, EditTodoState, Todo>(
  (ref, todo) {
    final updateTodoUseCase = ref.watch(updateTodoUseCaseProvider);
    return EditTodoViewModel(
      todo: todo,
      updateTodoUseCase: updateTodoUseCase,
      getUserById: ref.read(getUserByUserIdUsecaseProvider),
    );
  },
);
