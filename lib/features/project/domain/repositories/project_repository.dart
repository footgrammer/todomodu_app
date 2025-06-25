import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/shared/types/result.dart';

abstract class ProjectRepository {
  Future<Result<List<Project>>> fetchProjectsByUser(UserEntity user);

  // 새로 추가: projectId로 프로젝트 단건 조회
  Future<Result<Project>> fetchProjectById(String projectId);

  Future<List<Project>> fetchProjectsByUserId(String userId);
  Future<void> createProject(
    Project project,
  );
}
