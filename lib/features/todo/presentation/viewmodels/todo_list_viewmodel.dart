import 'package:flutter/material.dart';
import 'package:todomodu_app/features/todo/application/fetch_todos_usecase.dart';
import 'package:todomodu_app/features/todo/domain/entities/todo.dart';

class TodoListViewModel extends ChangeNotifier {
  final FetchTodosUsecase fetchTodosUsecase;

  TodoListViewModel(this.fetchTodosUsecase);

  List<Todo> todos = [];

  Future<void> fetchTodos() async {
    todos = await fetchTodosUsecase();
    notifyListeners();
  }
}