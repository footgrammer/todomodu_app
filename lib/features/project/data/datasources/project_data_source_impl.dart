import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todomodu_app/features/project/data/datasources/project_data_source.dart';
import 'package:todomodu_app/features/project/data/models/project_dto.dart';
import 'package:todomodu_app/features/todo/domain/entities/todo.dart';
import 'package:todomodu_app/shared/types/result.dart';

class ProjectDataSourceImpl implements ProjectDataSource {
  final FirebaseFirestore _firestore;

  ProjectDataSourceImpl({required FirebaseFirestore firestore})
    : _firestore = firestore;

  @override
  Future<Result<List<ProjectDto>>> getProjectsByUserId(String userId) async {
    try {
      final memberDocs =
          await _firestore
              .collectionGroup('members')
              .where('userId', isEqualTo: userId)
              .get();

      final projectIds =
          memberDocs.docs
              .map((doc) => doc.reference.parent.parent?.id)
              .whereType<String>()
              .toSet()
              .toList();

      if (projectIds.isEmpty) {
        return Result.ok([]);
      }

      final futures = projectIds.map((projectId) async {
        final projectDoc =
            await _firestore.collection('projects').doc(projectId).get();
        if (!projectDoc.exists) return null;
        return ProjectDto.fromJson(projectDoc.data()!..['id'] = projectDoc.id);
      });

      final projectList = await Future.wait(futures);
      final validProjects = projectList.whereType<ProjectDto>().toList();
      return Result.ok(validProjects);
    } catch (e) {
      return Result.error(Exception('Failed to load projects: $e'));
    }
  }

  @override
  Future<Result<List<String>>> getMemberIdsByProjectId(String projectId) async {
    try {
      final snapshot =
          await _firestore
              .collection('projects')
              .doc(projectId)
              .collection('members')
              .get();

      final ids = snapshot.docs.map((doc) => doc['userId'] as String).toList();
      return Result.ok(ids);
    } catch (e) {
      return Result.error(Exception('Failed to fetch memberIds: $e'));
    }
  }

  @override
  Future<void> createProject(
    ProjectDto projectDto,
    List<Todo> todoDtos,
    Map<String, List<String>> subtasks,
  ) async {
    // 프로젝트 생성
    final projectRef = await _firestore
        .collection('projects')
        .add(projectDto.toJson());
    await projectRef.update({'id': projectRef.id});

    //members 생성
    final memberRef = projectRef.collection('members').doc(projectDto.ownerId);
    memberRef.set({'userId': projectDto.ownerId});

    // todo 생성
    for (final todo in todoDtos) {
      final todoRef = projectRef.collection('todos').doc();

      await todoRef.set({
        'id': todoRef.id,
        'projectId': projectRef.id,
        'title': todo.title,
        'startDate': Timestamp.fromDate(todo.startDate),
        'endDate': Timestamp.fromDate(todo.endDate),
        'isDone': false,
      });

      // subtask 생성
      for (final subtask in subtasks[todo.title]!) {
        final subtaskRef = projectRef.collection('subtasks').doc();
        await todoRef.set({
          'id': subtaskRef.id,
          'todoId': todoRef.id,
          'projectId': projectRef.id,
          'title': subtask,
          'assigneeId': null,
        });
      }
    }
  }
}
