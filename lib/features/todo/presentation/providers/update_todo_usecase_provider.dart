import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/usecases/update_todo_usecase.dart';
import 'todo_repository_provider.dart';

final updateTodoUseCaseProvider = Provider<UpdateTodoUseCase>((ref) {
  final repository = ref.watch(todoRepositoryProvider);
  return UpdateTodoUseCase(repository);
});