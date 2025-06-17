import '../../domain/entities/sub_task.dart';

class EditTodoState {
  final String id;
  final String projectId;
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final List<SubTask> subTasks;

  EditTodoState({
    required this.id,
    required this.projectId,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.subTasks,
  });

  EditTodoState copyWith({
    String? title,
    DateTime? startDate,
    DateTime? endDate,
    List<SubTask>? subTasks,
  }) {
    return EditTodoState(
      id: id,
      projectId: projectId,
      title: title ?? this.title,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      subTasks: subTasks ?? this.subTasks,
    );
  }
}
