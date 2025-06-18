import 'package:todomodu_app/features/project/data/models/project_dto.dart';
<<<<<<< HEAD
import 'package:todomodu_app/shared/types/result.dart';

abstract interface class ProjectDataSource {
  Future<Result<List<ProjectDto>>> getProjectsByUserId(String userId);
  Future<Result<List<String>>> getMemberIdsByProjectId(String projectId);
=======

abstract interface class ProjectDataSource {
  // 메서드 정의만 해둠
  Future<List<ProjectDto>> getProjects();
>>>>>>> 61c9c2a (feat : change projectState and make usecases file)
}
