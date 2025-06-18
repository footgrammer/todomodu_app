import 'package:todomodu_app/features/project/data/models/project_dto.dart';
import 'package:todomodu_app/shared/types/result.dart';

abstract interface class ProjectDataSource {
  Future<Result<List<ProjectDto>>> getProjectsByUserId(String userId);
  Future<Result<List<String>>> getMemberIdsByProjectId(String projectId);
}
