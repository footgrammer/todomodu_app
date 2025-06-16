import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todomodu_app/features/project/data/datasources/project_data_source.dart';
import 'package:todomodu_app/features/project/data/models/project_dto.dart';
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
}
