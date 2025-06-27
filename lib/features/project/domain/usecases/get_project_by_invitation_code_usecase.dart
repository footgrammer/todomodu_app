import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/features/project/domain/repositories/project_repository.dart';

class GetProjectByInvitationCodeUsecase {
  final ProjectRepository _repository;

  GetProjectByInvitationCodeUsecase(this._repository);

  Future<Project?> execute(String code) {
    return _repository.getProjectByInvitationCode(code);
  }
}
