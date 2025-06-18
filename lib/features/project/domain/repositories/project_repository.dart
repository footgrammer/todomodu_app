import 'package:todomodu_app/features/project/domain/entities/project.dart';
<<<<<<< HEAD
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/shared/types/result.dart';

abstract interface class ProjectRepository {
  Future<Result<List<Project>>> fetchProjectsByUser(UserEntity user);
=======

abstract interface class ProjectRepository {
  Future<List<Project>> getProjects();
>>>>>>> 61c9c2a (feat : change projectState and make usecases file)
}
