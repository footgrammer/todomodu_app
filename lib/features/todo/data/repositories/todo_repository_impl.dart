import 'package:todomodu_app/features/todo/domain/entities/todo.dart';
import 'package:todomodu_app/features/todo/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository{
  final List<Todo> _storage = []; //임시 디비?

  @override
  Future<void> createTodo(Todo todo) async {
    _storage.add(todo);
  }


// 리스트 확인 메소드(테스트용)
  Future<List<Todo>> getAllTodos() async {
    return _storage;
  }
}