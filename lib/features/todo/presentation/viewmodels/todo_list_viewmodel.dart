import 'package:flutter/material.dart';import 'package:todomodu_app/features/todo/application/usecases/stream_todos_usecase.dart';
import 'package:todomodu_app/features/todo/domain/entities/todo.dart';

class TodoListViewModel extends ChangeNotifier {
  final StreamTodosUseCase streamTodosUseCase;

  TodoListViewModel(this.streamTodosUseCase);

  List<Todo> todos = [];

  Stream<List<Todo>> get todosStream => streamTodosUseCase();
  }