import 'package:todomodu_app/features/project/domain/entities/simple_project_info.dart';
import 'package:todomodu_app/features/project/domain/repositories/project_repository.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';

class WatchSimpleProjectsByUserUsecase {
  final ProjectRepository _repository;

  WatchSimpleProjectsByUserUsecase({required ProjectRepository repository})
      : _repository = repository;

  Stream<List<SimpleProjectInfo>> execute({required UserEntity user}) {
    return _repository.watchSimpleProjectInfosByUser(user);
  }
}
