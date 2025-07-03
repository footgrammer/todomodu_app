import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/features/project/domain/entities/simple_project_info.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/shared/types/result.dart';

abstract interface class ProjectRepository {
  Future<Result<List<Project>>> fetchProjectsByUser(UserEntity user);

  // 새로 추가: projectId로 프로젝트 단건 조회
  Future<Result<Project>> fetchProjectById(String projectId);

  Future<List<Project>> fetchProjectsByUserId(String userId);
  Future<void> createProject(
    Project project, // ✅ Entity
  );

  Future<void> deleteProject(String projectId);

  // 초대코드로 프로젝트 검색
  Future<Project?> getProjectByInvitationCode(String code);

  // 팀원 추가하기
  Future<void> addMemberToProject({
    required String projectId,
    required String userId,
  });

  Future<Result<List<SimpleProjectInfo>>> getSimpleProjectInfosByIds(
    List<String> ids,
  );
  // 사용자가 속한 프로젝트 ID들을 실시간으로 스트리밍
  Stream<List<String>> watchProjectIdsByUser(UserEntity user);
}
