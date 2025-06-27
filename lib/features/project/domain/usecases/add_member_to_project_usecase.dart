import 'package:todomodu_app/features/project/domain/repositories/project_repository.dart';

class AddMemberToProjectUsecase {
  final ProjectRepository _projectRepository;

  AddMemberToProjectUsecase(this._projectRepository);

  Future<void> execute({
    required String projectId,
    required String userId,
  }) async {
    await _projectRepository.addMemberToProject(
      projectId: projectId,
      userId: userId,
    );
  }
}
