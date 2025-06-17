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
