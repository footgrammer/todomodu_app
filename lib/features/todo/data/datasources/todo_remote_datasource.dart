import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todomodu_app/features/todo/data/models/todo_dto.dart';
import 'package:todomodu_app/shared/types/result.dart';
import '../../domain/entities/todo.dart';
import '../../domain/entities/subtask.dart';

class TodoRemoteDataSource {
  final FirebaseFirestore _firestore;

  TodoRemoteDataSource(this._firestore);

  Future<void> createTodo(Todo todo) async {
    final todoDoc = _firestore.collection('todos').doc(todo.id);

    await todoDoc.set({
      'projectId': todo.projectId,
      'title': todo.title,
      'startDate': todo.startDate.toIso8601String(),
      'endDate': todo.endDate.toIso8601String(),
      'isDone': todo.isDone,
    });

    for (final subtask in todo.subTasks) {
      final subTaskDoc = todoDoc.collection('subTasks').doc(subtask.id);
      await subTaskDoc.set({'title': subtask.title, 'isDone': subtask.isDone});
    }
  }

  Stream<List<Todo>> streamTodos() {
    return _firestore.collection('todos').snapshots().asyncMap((
      snapshot,
    ) async {
      List<Todo> todos = [];

      for (final doc in snapshot.docs) {
        final data = doc.data();

        final subTaskSnapshot =
            await doc.reference.collection('subtasks').get();

        final subTasks =
            subTaskSnapshot.docs.map((subDoc) {
              final subData = subDoc.data();
              return Subtask(
                id: subDoc.id,
                todoId: doc.id,
                title: subData['title'],
                isDone: subData['isDone'],
                assignee: null,
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

  Future<Result<List<TodoDto>>> getTodosByProjectId(String projectId) async {
    try {
      final snapshot =
          await _firestore
              .collection('projects')
              .doc(projectId)
              .collection('todos')
              .get();

      final todos =
          snapshot.docs.map((doc) {
            final data = doc.data();
            return TodoDto.fromJson(data, id: doc.id);
          }).toList();

      return Result.ok(todos);
    } catch (e) {
      return Result.error(
        Exception('Failed to load todos for project $projectId: $e'),
      );
    }
  }
}
