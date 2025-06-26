import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todomodu_app/features/todo/data/models/todo_dto.dart';
import 'package:todomodu_app/features/todo/data/models/subtask_dto.dart';
import 'package:todomodu_app/features/todo/domain/entities/todo.dart';
import 'package:todomodu_app/shared/types/result.dart';

class TodoRemoteDataSource {
  final FirebaseFirestore _firestore;

  TodoRemoteDataSource(this._firestore);

  Future<void> createTodo(Todo todo) async {
    final todoDto = TodoDto.fromEntity(todo);
    final todoDoc = _firestore
        .collection('projects')
        .doc(todo.projectId)
        .collection('todos')
        .doc(todo.id);

    await todoDoc.set(todoDto.toJson());

    final subtasksRef = _firestore
        .collection('projects')
        .doc(todo.projectId)
        .collection('subtasks');

    for (final subtask in todo.subtasks) {
      final subtaskDto = SubtaskDto.fromEntity(subtask);
      await subtasksRef.doc(subtask.id).set(subtaskDto.toJson());
    }
  }

  Stream<List<Todo>> streamTodos(String projectId) {
    return _firestore
        .collection('projects')
        .doc(projectId)
        .collection('todos')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final dto = TodoDto.fromJson(doc.data(), id: doc.id);
        return dto.toEntity(); // subtasks는 따로 fetch 필요
      }).toList();
    });
  }

  Future<Result<List<TodoDto>>> getTodosByProjectId(String projectId) async {
    try {
      final snapshot = await _firestore
          .collection('projects')
          .doc(projectId)
          .collection('todos')
          .get();

      final todos = snapshot.docs
          .map((doc) => TodoDto.fromJson(doc.data(), id: doc.id))
          .toList();

      return Result.ok(todos);
    } catch (e) {
      return Result.error(
        Exception('Failed to load todos for project $projectId: $e'),
      );
    }
  }

  Future<void> deleteTodo(String projectId, String todoId) async {
    final todoRef = _firestore
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
    final subtaskRef = _firestore
        .collection('projects')
        .doc(projectId)
        .collection('subtasks')
        .doc(subtaskId);

    await subtaskRef.update({'isDone': isDone});
  }

  Future<void> updateTodo(Todo todo) async {
    final todoDto = TodoDto.fromEntity(todo);
    final todoDoc = _firestore
        .collection('projects')
        .doc(todo.projectId)
        .collection('todos')
        .doc(todo.id);

    await todoDoc.set(todoDto.toJson());

    final subtasksRef = _firestore
        .collection('projects')
        .doc(todo.projectId)
        .collection('subtasks');

    final snapshot =
        await subtasksRef.where('todoId', isEqualTo: todo.id).get();

    final firestoreSubtaskIds = snapshot.docs.map((doc) => doc.id).toSet();
    final incomingSubtaskIds = todo.subtasks.map((s) => s.id).toSet();

    final idsToDelete = firestoreSubtaskIds.difference(incomingSubtaskIds);
    for (final id in idsToDelete) {
      await subtasksRef.doc(id).delete();
    }

    for (final subtask in todo.subtasks) {
      final subtaskDto = SubtaskDto.fromEntity(subtask);
      final docRef = subtasksRef.doc(subtask.id);
      final doc = await docRef.get();
      if (doc.exists) {
        await docRef.update(subtaskDto.toJson());
      } else {
        await docRef.set(subtaskDto.toJson());
      }
    }
  }
}
