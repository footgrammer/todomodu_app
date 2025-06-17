class Subtask {
  final String id;
  final String title;
  final bool isDone;

  Subtask({
    required this.id,
    required this.title,
    required this.isDone,
  });

  Subtask copyWith({
    String? id,
    String? title,
    bool? isDone,
  }) {
    return Subtask(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isDone': isDone,
    };
  }

  factory Subtask.fromMap(Map<String, dynamic> map) {
    return Subtask(
      id: map['id'],
      title: map['title'],
      isDone: map['isDone'],
    );
  }
}
