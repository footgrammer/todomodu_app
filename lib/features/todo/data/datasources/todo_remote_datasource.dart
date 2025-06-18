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

    final subtasksRef = firestore
        .collection('projects')
        .doc(todo.projectId)
        .collection('subtasks');

    for (final subtask in todo.subtasks) {
      await subtasksRef.doc(subtask.id).set(subtask.toMap());
    }
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
    final todoRef = firestore
        .collection('projects')
        .doc(projectId)
        .collection('todos')
        .doc(todoId);

    await todoRef.delete();
  }

  Future<void> toggleSubtaskDone({
    required String projectId,
    required String todoId,
    required String subtaskId,
    required bool isDone,
  }) async {
    final subtaskRef = firestore
        .collection('projects')
        .doc(projectId)
        .collection('subtasks')
        .doc(subtaskId);

    await subtaskRef.update({'isDone': isDone});
  }

Future<void> updateTodo(Todo todo) async {
  final todoDoc = firestore
      .collection('projects')
      .doc(todo.projectId)
      .collection('todos')
      .doc(todo.id);

  await todoDoc.set(todo.toMap());

  final subtasksRef = firestore
      .collection('projects')
      .doc(todo.projectId)
      .collection('subtasks');

  final snapshot = await subtasksRef
      .where('todoId', isEqualTo: todo.id)
      .get();

  final firestoreSubtaskIds = snapshot.docs.map((doc) => doc.id).toSet();
  final incomingSubtaskIds = todo.subtasks.map((s) => s.id).toSet();

  final idsToDelete = firestoreSubtaskIds.difference(incomingSubtaskIds);
  for (final id in idsToDelete) {
    await subtasksRef.doc(id).delete();
  }

  for (final subtask in todo.subtasks) {
    final docRef = subtasksRef.doc(subtask.id);
    final doc = await docRef.get();
    if (doc.exists) {
      await docRef.update(subtask.toMap());
    } else {
      await docRef.set(subtask.toMap());
    }
  }
}

}
