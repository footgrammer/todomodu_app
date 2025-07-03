import 'package:todomodu_app/features/project/data/models/project_dto.dart';
import 'package:todomodu_app/features/todo/domain/entities/todo.dart';
import 'package:todomodu_app/shared/types/result.dart';

abstract interface class ProjectDataSource {
  Future<Result<List<ProjectDto>>> getProjectsByUserId(String userId);
  Future<Result<List<String>>> getMemberIdsByProjectId(String projectId);
  Future<ProjectDto?> getProjectDtoById(String projectId); //추가
  Future<List<ProjectDto>> fetchProjectsByUserId(String userId);
  Future<void> createProject(ProjectDto projectDto, List<Todo> todoDto);
  Future<ProjectDto?> getProjectByInvitationCode(String code);
  Future<void> addMemberToProject({
    required String projectId,
    required String userId,
  });
  Future<void> deleteProject(String projectId);
  Future<Result<List<ProjectDto>>> getProjectDtosByIds(List<String> ids);
  Stream<List<String>> watchProjectIdsByUserId(String userId);
}
