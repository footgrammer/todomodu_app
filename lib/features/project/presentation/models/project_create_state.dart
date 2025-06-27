import 'package:collection/collection.dart';

class ProjectCreateState {
  final String title;
  final String description;
  final DateTime? startDate;
  final DateTime? endDate;
  final Set<String> selectedTodos;
  final Map<String, Set<String>> selectedSubtasks;
  final Set<String>? expandedItems;
  final bool isLoading;
  final bool isDataSet;
  final String? errorMessage;

  ProjectCreateState({
    this.title = '',
    this.description = '',
    this.startDate,
    this.endDate,
    this.selectedTodos = const {},
    this.selectedSubtasks = const {},
    this.expandedItems,
    this.isLoading = false,
    this.errorMessage,
    this.isDataSet = false,
  });

  ProjectCreateState copyWith({
    String? title,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Set<String>? selectedTodos,
    Map<String, Set<String>>? selectedSubtasks,
    Set<String>? expandedItems,
    bool? isLoading,
    String? errorMessage,
    bool? isDataSet,
  }) {
    return ProjectCreateState(
      title: title ?? this.title,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      selectedTodos: selectedTodos ?? this.selectedTodos,
      selectedSubtasks: selectedSubtasks ?? this.selectedSubtasks,
      expandedItems: expandedItems ?? this.expandedItems,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isDataSet: isDataSet ?? this.isDataSet,
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
