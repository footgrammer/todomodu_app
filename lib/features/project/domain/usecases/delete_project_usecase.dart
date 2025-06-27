import 'package:todomodu_app/features/project/domain/repositories/project_repository.dart';

class DeleteProjectUsecase {
  final ProjectRepository repository;

  DeleteProjectUsecase(this.repository);
  Future<void> execute({required String projectId}) {
    return repository.deleteProject(projectId);
  }
}
