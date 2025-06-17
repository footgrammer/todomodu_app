import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/todo.dart';
import '../../domain/entities/subtask.dart';

class TodoRemoteDataSource {
  final FirebaseFirestore firestore;

  TodoRemoteDataSource(this.firestore);

  Future<void> createTodo(Todo todo) async {
    final todoDoc = firestore
        .collection('projects')
        .doc(todo.projectId)
        .collection('todos')
        .doc(todo.id);

    await todoDoc.set(todo.toMap());
  }

  Stream<List<Todo>> streamTodos(String projectId) {
    return firestore
        .collection('projects')
        .doc(projectId)
        .collection('todos')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Todo.fromMap(doc.id, doc.data());
      }).toList();
    });
  }

  Future<void> deleteTodo(String projectId, String todoId) async {
    final todoDoc = firestore
        .collection('projects')
        .doc(projectId)
        .collection('todos')
        .doc(todoId);

    await todoDoc.delete();
  }

  Future<void> toggleSubtaskDone({
    required String projectId,
    required String todoId,
    required String subtaskId,
    required bool isDone,
  }) async {
    final todoDoc = firestore
        .collection('projects')
        .doc(projectId)
        .collection('todos')
        .doc(todoId);

    final docSnapshot = await todoDoc.get();
    final data = docSnapshot.data();
    if (data == null) return;

    final subtasks = (data['subtasks'] as List<dynamic>).map((e) => Subtask.fromMap(e as Map<String, dynamic>)).toList();

    final updatedSubtasks = subtasks.map((subtask) {
      if (subtask.id == subtaskId) {
        return subtask.copyWith(isDone: isDone);
      }
      return subtask;
    }).toList();

    await todoDoc.update({
      'subtasks': updatedSubtasks.map((e) => e.toMap()).toList(),
    });
  }

  Future<void> updateTodo(Todo todo) async {
    final todoDoc = firestore
        .collection('projects')
        .doc(todo.projectId)
        .collection('todos')
        .doc(todo.id);

    await todoDoc.set(todo.toMap());
  }
}
