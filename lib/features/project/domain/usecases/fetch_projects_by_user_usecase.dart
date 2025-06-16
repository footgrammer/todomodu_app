import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/features/project/domain/repositories/project_repository.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/shared/types/result.dart';

class FetchProjectsByUserUsecase {
  final ProjectRepository _projectRepository;
  FetchProjectsByUserUsecase({required projectRepository})
    : _projectRepository = projectRepository;

  Future<Result<List<Project>>> execute(UserEntity user) {
    return _projectRepository.fetchProjectsByUser(user);
  }
}
