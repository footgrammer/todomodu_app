import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/features/project/domain/repositories/project_repository.dart';

class GetProjectsUsecase {
  GetProjectsUsecase(this._projectRepository);
  final ProjectRepository _projectRepository;

  Future<List<Project>> execute() async {
    return await _projectRepository.getProjects();
  }
}
