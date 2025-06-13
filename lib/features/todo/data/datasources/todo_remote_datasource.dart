import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/todo.dart';
import '../../domain/entities/sub_task.dart';

class TodoRemoteDatasource {
  final FirebaseFirestore firestore;

  TodoRemoteDatasource(this.firestore);

  Future<void> createTodo(Todo todo) async {
    final todoDoc = firestore.collection('todos').doc(todo.id);

    await todoDoc.set({
      'projectId': todo.projectId,
      'title': todo.title,
      'startDate': todo.startDate.toIso8601String(),
      'endDate': todo.endDate.toIso8601String(),
      'isDone': todo.isDone,
    });

    for (final subTask in todo.subTasks) {
      final subTaskDoc = todoDoc.collection('subTasks').doc(subTask.id);
      await subTaskDoc.set({
        'title': subTask.title,
        'isDone': subTask.isDone,
      });
    }
  }
}