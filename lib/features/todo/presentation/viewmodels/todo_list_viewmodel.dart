import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/todo/application/usecases/stream_todos_usecase.dart';
import '../../domain/entities/todo.dart';
import '../providers/stream_todos_usecase_provider.dart';

class TodoListViewModel {
  final StreamTodosUseCase streamTodosUseCase;

  TodoListViewModel(this.streamTodosUseCase);

  Stream<List<Todo>> todosStream(String projectId) {
    return streamTodosUseCase.call(projectId);
  }
}
