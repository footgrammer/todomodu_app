import 'package:todomodu_app/features/project/domain/entities/project.dart';

extension ProjectProgressExtension on Project {
  double get progress {
    final subtasks = todos.expand((t) => t.subtasks).toList();
    if (subtasks.isEmpty) return 0.0;
    final done = subtasks.where((s) => s.isDone).length;
    return done / subtasks.length;
  }

  int get progressPercent => (progress * 100).round();
}
