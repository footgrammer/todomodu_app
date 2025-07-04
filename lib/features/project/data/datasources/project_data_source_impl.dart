import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todomodu_app/features/project/data/datasources/project_data_source.dart';
import 'package:todomodu_app/features/project/data/models/project_dto.dart';
import 'package:todomodu_app/shared/types/result.dart';

class ProjectDataSourceImpl implements ProjectDataSource {
  final FirebaseFirestore _firestore;

  ProjectDataSourceImpl({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _projectsRef =>
      _firestore.collection('projects');

  @override
  Future<Result<List<ProjectDto>>> getProjectsByUserId(String userId) async {
    try {
      final query =
          await _projectsRef.where('memberIds', arrayContains: userId).get();

      final dtos =
          query.docs
              .map((doc) => ProjectDto.fromJson({...doc.data(), 'id': doc.id}))
              .toList();
      return Result.ok(dtos);
    } catch (e) {
      return Result.error(Exception('getProjectsByUserId failed: $e'));
    }
  }

  @override
  Future<ProjectDto?> getProjectDtoById(String projectId) async {
    final doc = await _projectsRef.doc(projectId).get();
    if (!doc.exists) return null;

    return ProjectDto.fromJson({...doc.data()!, 'id': doc.id});
  }

  @override
  Future<List<ProjectDto>> fetchProjectsByUserId(String userId) async {
    final query =
        await _projectsRef.where('memberIds', arrayContains: userId).get();

    return query.docs
        .map((doc) => ProjectDto.fromJson({...doc.data(), 'id': doc.id}))
        .toList();
  }

  @override
  Future<void> createProject(ProjectDto projectDto, List todos) async {
    final docRef = _projectsRef.doc(projectDto.id);
    await docRef.set(projectDto.toJson());
  }

  @override
  Future<void> deleteProject(String projectId) async {
    await _projectsRef.doc(projectId).delete();
  }

  @override
  Future<void> addMemberToProject({
    required String projectId,
    required String userId,
  }) async {
    final docRef = _projectsRef.doc(projectId);
    await docRef.update({
      'memberIds': FieldValue.arrayUnion([userId]),
    });
  }

  @override
  Future<ProjectDto?> getProjectByInvitationCode(String code) async {
    final query =
        await _projectsRef
            .where('invitationCode', isEqualTo: code)
            .limit(1)
            .get();

    if (query.docs.isEmpty) return null;

    final doc = query.docs.first;
    return ProjectDto.fromJson({...doc.data(), 'id': doc.id});
  }

  @override
  Future<Result<List<String>>> getMemberIdsByProjectId(String projectId) async {
    try {
      final doc = await _projectsRef.doc(projectId).get();
      if (!doc.exists) return Result.error(Exception('Project not found'));

      final data = doc.data();
      final List<String> memberIds = List<String>.from(
        data?['memberIds'] ?? [],
      );
      return Result.ok(memberIds);
    } catch (e) {
      return Result.error(Exception('getMemberIdsByProjectId failed: $e'));
    }
  }

  @override
  Future<Result<List<ProjectDto>>> getProjectDtosByIds(List<String> ids) async {
    try {
      if (ids.isEmpty) return Result.ok([]);

      final snapshots = await Future.wait(
        ids.map((id) => _projectsRef.doc(id).get()),
      );

      final dtos =
          snapshots
              .where((doc) => doc.exists)
              .map((doc) => ProjectDto.fromJson({...doc.data()!, 'id': doc.id}))
              .toList();

      return Result.ok(dtos);
    } catch (e) {
      return Result.error(Exception('getProjectDtosByIds failed: $e'));
    }
  }

  @override
  Stream<List<String>> watchProjectIdsByUserId(String userId) {
    return _projectsRef
        .where('memberIds', arrayContains: userId)
        .snapshots()
        .map((snap) => snap.docs.map((doc) => doc.id).toList());
  }

  @override
  Stream<List<ProjectDto>> watchProjectDtosByUserId(String userId) {
    return _firestore
        .collection('projects')
        .where('memberIds', arrayContains: userId)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final data = doc.data();
            return ProjectDto.fromJson({
              ...data,
              'id': doc.id, // id는 문서 ID로 수동 삽입
            });
          }).toList();
        });
  }
}
