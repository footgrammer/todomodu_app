class Subtask {
  final String id;
  final String title;
  final bool isDone;
  final String todoId;
  final String projectId;

  Subtask({
    required this.id,
    required this.title,
    required this.isDone,
    required this.todoId,
    required this.projectId,
  });

  Subtask copyWith({
    String? id,
    String? title,
    bool? isDone,
    String? todoId,
    String? projectId,
  }) {
    return Subtask(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      todoId: todoId ?? this.todoId,
      projectId: projectId ?? this.projectId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isDone': isDone,
      'todoId': todoId,
      'projectId': projectId,
    };
  }

  factory Subtask.fromMap(Map<String, dynamic> map) {
    return Subtask(
      id: map['id'],
      title: map['title'],
      isDone: map['isDone'],
      todoId: map['todoId'],
      projectId: map['projectId'],
    );
  }
}
