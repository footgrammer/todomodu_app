import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/features/project/domain/repositories/project_repository.dart';
import 'package:todomodu_app/shared/types/result.dart';

class FetchProjectByIdUsecase {
  final ProjectRepository _repository;
  FetchProjectByIdUsecase({required ProjectRepository repository})
    : _repository = repository;

  Future<Result<Project>> execute(String projectId) {
    return _repository.fetchProjectById(projectId);
  }
}
