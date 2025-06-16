import 'package:todomodu_app/features/project/data/datasources/project_data_source.dart';
import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/features/project/domain/repositories/project_repository.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/features/user/domain/repositories/user_repository.dart';
import 'package:todomodu_app/shared/types/result.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectDataSource _dataSource;

  ProjectRepositoryImpl({required ProjectDataSource dataSource})
    : _dataSource = dataSource;
  final UserRepository _userRepository;
  final TodoRepository _todoRepository;

  @override
  Future<Result<List<Project>>> fetchProjectsByUser(UserEntity user) async {
    final result = await _dataSource.getProjectsByUserId(user.id);

    return switch (result) {
      Ok(value: final dtoList) => Result.ok(
        dtoList.map((dto) => dto.toEntity()).toList(),
      ),
      Error(:final error) => Result.error(error),
    };
  }
}
