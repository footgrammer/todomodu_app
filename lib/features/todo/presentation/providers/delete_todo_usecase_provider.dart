import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/usecases/delete_todo_usecase.dart';
import 'todo_repository_provider.dart';

final deleteTodoUseCaseProvider = Provider<DeleteTodoUseCase>((ref) {
  final repository = ref.watch(todoRepositoryProvider);
  return DeleteTodoUseCase(repository);
});
