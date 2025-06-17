import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/todo.dart';
import '../../domain/entities/sub_task.dart';

class TodoRemoteDataSource {
  final FirebaseFirestore firestore;

  TodoRemoteDataSource(this.firestore);

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

  Stream<List<Todo>> streamTodos() {
  return firestore.collection('todos').snapshots().asyncMap((snapshot) async {

    List<Todo> todos = [];

    for (final doc in snapshot.docs) {
      final data = doc.data();

      final subTaskSnapshot = await doc.reference.collection('subTasks').get();

      final subTasks = subTaskSnapshot.docs.map((subDoc) {
        final subData = subDoc.data();
        return SubTask(
          id: subDoc.id,
          todoId: doc.id,
          title: subData['title'],
          isDone: subData['isDone'],
        );
      }).toList();

      final todo = Todo(
        id: doc.id,
        projectId: data['projectId'],
        title: data['title'],
        startDate: DateTime.parse(data['startDate']),
        endDate: DateTime.parse(data['endDate']),
        isDone: data['isDone'],
        subTasks: subTasks,
      );

      todos.add(todo);
    }

    return todos;
  });
}
}