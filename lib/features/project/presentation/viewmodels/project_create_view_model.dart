import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProjectCreateState {
  final String title;
  final String description;
  final DateTime? startDate;
  final DateTime? endDate;
  final Set<String> selectedTodos;
  final Map<String, Set<String>> selectedSubtasks;
  final Set<String>? expandedItems;

  ProjectCreateState({
    this.title = '',
    this.description = '',
    this.startDate,
    this.endDate,
    this.selectedTodos = const {},
    this.selectedSubtasks = const {},
    this.expandedItems,
  });

  ProjectCreateState copyWith({
    String? title,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Set<String>? selectedTodos,
    Map<String, Set<String>>? selectedSubtasks,
    Set<String>? expandedItems,
  }) {
    return ProjectCreateState(
      title: title ?? this.title,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      selectedTodos: selectedTodos ?? this.selectedTodos,
      selectedSubtasks: selectedSubtasks ?? this.selectedSubtasks,
      expandedItems: expandedItems ?? this.expandedItems,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectCreateState &&
          DeepCollectionEquality().equals(selectedTodos, other.selectedTodos) &&
          DeepCollectionEquality().equals(
            selectedSubtasks,
            other.selectedSubtasks,
          ) &&
          DeepCollectionEquality().equals(expandedItems, other.expandedItems);

  static const _equality = DeepCollectionEquality();

  @override
  int get hashCode => Object.hash(
    _equality.hash(selectedTodos),
    _equality.hash(selectedSubtasks),
    _equality.hash(expandedItems),
  );
}

class ProjectCreateViewModel extends Notifier<ProjectCreateState> {
  Map<String, Set<String>>? _initialSubtaskSnapshot;

  void cacheInitialSubtasks(Map<String, Set<String>> snapshot) {
    _initialSubtaskSnapshot ??= {
      for (final entry in snapshot.entries) entry.key: {...entry.value},
    };
  }

  Map<String, Set<String>> get initialSubtasks => _initialSubtaskSnapshot ?? {};

  @override
  ProjectCreateState build() {
    return ProjectCreateState();
  }

  void selectAllTodos(List<dynamic> todos) {
    final allTodos = todos.map((todo) => todo['todoTitle'] as String).toSet();
    state = state.copyWith(selectedTodos: allTodos);
  }

  void selectAllSubtasks(List<dynamic> todos) {
    final Map<String, Set<String>> newSelectedSubtasks = {};
    for (final todo in todos) {
      final String todoTitle = todo['todoTitle'];
      final List<dynamic> subtasks = todo['subtasks'];

      if (state.selectedTodos.contains(todoTitle)) {
        newSelectedSubtasks[todoTitle] =
            subtasks.map((e) => e.toString()).toSet();
      }
    }

    // 기존 selectedSubtasks와 병합 (기존 값 유지하려면 merge 방식도 가능)
    state = state.copyWith(
      selectedSubtasks: {...state.selectedSubtasks, ...newSelectedSubtasks},
    );
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

  void toggleSubtask(String todo, String subtask) {
    final current = state.selectedSubtasks[todo] ?? <String>{};
    final updated = {...current};
    if (updated.contains(subtask)) {
      updated.remove(subtask);
    } else {
      updated.add(subtask);
    }

    final newMap = {...state.selectedSubtasks, todo: updated};
    state = state.copyWith(selectedSubtasks: newMap);
  }

  void toggleExpandedItems(String todo) {
    final current = state.expandedItems ?? <String>{};
    final updated = {...current};

    if (updated.contains(todo)) {
      updated.remove(todo); // 이미 열려 있으면 닫기
    } else {
      updated.add(todo); // 닫혀 있으면 열기
    }

    state = state.copyWith(expandedItems: updated);
  }

  void reset() {
    state = ProjectCreateState();
  }
}

final projectCreateViewModelProvider =
    NotifierProvider<ProjectCreateViewModel, ProjectCreateState>(() {
      return ProjectCreateViewModel();
    });
