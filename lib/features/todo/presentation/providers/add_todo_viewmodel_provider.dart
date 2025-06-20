import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/todo/presentation/providers/create_todo_usecase_provider.dart';
import 'package:todomodu_app/features/todo/presentation/viewmodels/add_todo_viewmodel.dart';

final addTodoViewModelProvider = ChangeNotifierProvider.autoDispose.family<AddTodoViewModel, String>((ref, projectId) {
  final useCase = ref.read(createTodoUseCaseProvider);
  return AddTodoViewModel(useCase, projectId: projectId);
});
