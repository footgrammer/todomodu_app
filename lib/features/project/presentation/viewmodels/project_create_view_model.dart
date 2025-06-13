import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProjectCreateState {
  final String title;
  final String description;
  final DateTime? startDate;
  final DateTime? endDate;
  final Set<String> selectedTodos;
  final Map<String, Set<String>> selectedSubTasks;

  ProjectCreateState({
    this.title = '',
    this.description = '',
    this.startDate,
    this.endDate,
    this.selectedTodos = const {},
    this.selectedSubTasks = const {},
  });
}

extension ProjectCreateStateCopyWith on ProjectCreateState {
  ProjectCreateState copyWith({
    String? title,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Set<String>? selectedTodos,
    Map<String, Set<String>>? selectedSubTasks,
  }) {
    return ProjectCreateState(
      title: title ?? this.title,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      selectedTodos: selectedTodos ?? this.selectedTodos,
      selectedSubTasks: selectedSubTasks ?? this.selectedSubTasks,
    );
  }
}

class ProjectCreateViewModel extends Notifier<ProjectCreateState> {
  @override
  ProjectCreateState build() {
    return ProjectCreateState();
  }

  void selectAllTodo(List<dynamic> todos) {
    final allTodos = todos.map((todo) => todo['todoTitle'] as String).toSet();
    state = state.copyWith(selectedTodos: allTodos);
  }

  void toggleTodo(String todo) {
    final updated = Set<String>.from(state.selectedTodos);
    if (updated.contains(todo)) {
      updated.remove(todo);
    } else {
      updated.add(todo);
    }
    state = state.copyWith(selectedTodos: updated);
  }

  void reset() {
    state = ProjectCreateState();
  }
}

final projectCreateViewModelProvider =
    NotifierProvider<ProjectCreateViewModel, ProjectCreateState>(() {
      return ProjectCreateViewModel();
    });
