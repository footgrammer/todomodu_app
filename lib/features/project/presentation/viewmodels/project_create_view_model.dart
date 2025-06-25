import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/features/project/domain/usecases/create_project_usecase.dart';
import 'package:todomodu_app/features/project/presentation/models/project_create_state.dart';
import 'package:todomodu_app/features/todo/domain/entities/todo.dart';
import 'package:todomodu_app/shared/utils/log_if_debug.dart';

class ProjectCreateViewModel extends Notifier<ProjectCreateState> {
  Map<String, Set<String>>? _initialSubtaskSnapshot;

  @override
  ProjectCreateState build() {
    return ProjectCreateState(isLoading: false);
  }

  // 프로젝트 생성하기
  Future<void> createProject(
    Project project,
    CreateProjectUsecase usecase,
  ) async {
    // 로딩 시작
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      await usecase.execute(project);
      // 완료 후 로딩 false(에러 없음)
      state = state.copyWith(isLoading: false);
    } catch (error) {
      //실패 시 에러 메시지 추가
      state = state.copyWith(
        isLoading: false,
        errorMessage: '프로젝트 생성 실패 : $error',
      );
    }
  }

  void updateProjectInfo({
    required String title,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    state = state.copyWith(
      title: title,
      description: description,
      startDate: startDate,
      endDate: endDate,
    );
  }

  void cacheInitialSubtasks(Map<String, Set<String>> snapshot) {
    _initialSubtaskSnapshot ??= {
      for (final entry in snapshot.entries) entry.key: {...entry.value},
    };
  }

  Map<String, Set<String>> get initialSubtasks => _initialSubtaskSnapshot ?? {};

  void selectAllTodos(List<dynamic> todos) {
    final allTodos = todos.map((todo) => todo.todoTitle as String).toSet();
    state = state.copyWith(selectedTodos: allTodos);
  }

  void selectAllSubtasks(List<dynamic> todos) {
    final Map<String, Set<String>> newSelectedSubtasks = {};
    for (final todo in todos) {
      final String todoTitle = todo.todoTitle;
      final List<dynamic> subtasks = todo.subtasks;

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

  void updateSelectedSubtasks(String todo, Set<String> updatedSubtasks) {
    final updatedMap = {...state.selectedSubtasks, todo: updatedSubtasks};

    state = state.copyWith(selectedSubtasks: updatedMap);
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
