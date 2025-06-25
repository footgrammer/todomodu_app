import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todomodu_app/features/todo/data/models/todo_dto.dart';
import 'package:todomodu_app/shared/types/result.dart';
import '../../domain/entities/todo.dart';
import '../../domain/entities/subtask.dart';

class TodoRemoteDataSource {
  final FirebaseFirestore _firestore;

  TodoRemoteDataSource(this._firestore);

  Future<void> createTodo(Todo todo) async {
    final todoDoc = _firestore
        .collection('projects')
        .doc(todo.projectId)
        .collection('todos')
        .doc(todo.id);

    await todoDoc.set(todo.toMap());

    final subtasksRef = _firestore
        .collection('projects')
        .doc(todo.projectId)
        .collection('subtasks');
    for (final subtask in todo.subtasks) {
      await subtasksRef.doc(subtask.id).set(subtask.toMap());
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
            return Todo.fromMap(doc.id, doc.data());
          }).toList();
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

      final todos = <TodoDto>[];
      for (final doc in snapshot.docs) {
        try {
          final data = doc.data();
          final dto = TodoDto.fromJson(data, id: doc.id);
          todos.add(dto);
          log('✅ TodoDto 파싱 성공: ${dto.title} (${dto.id})');
        } catch (e) {
          log(
            '❌ TodoDto.fromJson 실패: project=$projectId, todoId=${doc.id}, error=$e',
          );
          // continue; // 생략 가능
        }
      }
      return Result.ok(todos);
    } catch (e) {
      log('❌ TodoDto 파싱 실패: error: $e');
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
    final todoDoc = _firestore
        .collection('projects')
        .doc(todo.projectId)
        .collection('todos')
        .doc(todo.id);

    await todoDoc.set(todo.toMap());

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
