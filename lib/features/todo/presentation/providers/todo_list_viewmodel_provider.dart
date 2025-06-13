
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/todo/presentation/providers/fetch_todos_usecase_provider.dart';
import 'package:todomodu_app/features/todo/presentation/viewmodels/todo_list_viewmodel.dart';

final TodoListViewModelProvider = ChangeNotifierProvider<TodoListViewModel>((ref){
  final useCase = ref.read(fetchTodosUsecaseProvider);
  return TodoListViewModel(useCase);

});