import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/features/project/domain/repositories/project_repository.dart';

class FetchProjectsByUserIdUsecase {
  final ProjectRepository _projectRepository;
  FetchProjectsByUserIdUsecase({required projectRepository})
    : _projectRepository = projectRepository;

  Future<List<Project>> execute(String userId) {
    return _projectRepository.fetchProjectsByUserId(userId);
  }
}
