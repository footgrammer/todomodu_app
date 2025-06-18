import '../../domain/entities/subtask.dart';

class EditTodoState {
  final String id;
  final String projectId;
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final List<Subtask> subtasks;

  EditTodoState({
    required this.id,
    required this.projectId,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.subtasks,
  });

  EditTodoState copyWith({
    String? title,
    DateTime? startDate,
    DateTime? endDate,
    List<Subtask>? subtasks,
  }) {
    return EditTodoState(
      id: id,
      projectId: projectId,
      title: title ?? this.title,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      subtasks: subtasks ?? this.subtasks,
    );
  }
}
