import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/stream_todos_usecase.dart';
import 'todo_repository_provider.dart';

final streamTodosUseCaseProvider = Provider<StreamTodosUseCase>((ref) {
  final repository = ref.read(todoRepositoryProvider);
  return StreamTodosUseCase(repository);
});