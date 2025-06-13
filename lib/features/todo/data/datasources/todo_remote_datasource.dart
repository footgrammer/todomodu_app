import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/todo.dart';
import '../../domain/entities/sub_task.dart';

class TodoRemoteDatasource {
  final FirebaseFirestore firestore;

  TodoRemoteDatasource(this.firestore);

  Future<void> createTodo(Todo todo) async {
    await firestore.collection('todos').add({
      'projectId': todo.projectId,
      'title': todo.title,
      'startDate': todo.startDate.toIso8601String(),
      'endDate': todo.endDate.toIso8601String(),
      'isDone': todo.isDone,
      'subTasks': [],
    });
  }

    Future<List<Todo>> fetchTodos() async {
      final snapshot = await firestore.collection('todos').get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Todo(
          id: doc.id,
          projectId: data['projectId'],
          title: data['title'],
          startDate: DateTime.parse(data['startDate']),
          endDate: DateTime.parse(data['endDate']),
          isDone: data['isDone'],
          subTasks: [],
        );
      }).toList();
    }
  }