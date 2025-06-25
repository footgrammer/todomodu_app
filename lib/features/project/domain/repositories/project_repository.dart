import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/shared/types/result.dart';

abstract interface class ProjectRepository {
  Future<Result<List<Project>>> fetchProjectsByUser(UserEntity user);

  Future<List<Project>> fetchProjectsByUserId(String userId);
  Future<void> createProject(
    Project project, // ✅ Entity
  );
}
