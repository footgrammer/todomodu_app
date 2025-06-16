import 'package:todomodu_app/features/project/data/datasources/project_data_source.dart';
import 'package:todomodu_app/features/project/data/models/project_dto.dart';
import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/features/project/domain/repositories/project_repository.dart';
import 'package:todomodu_app/features/todo/domain/entities/todo.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/features/user/domain/repositories/user_repository.dart';
import 'package:todomodu_app/shared/types/result.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectDataSource _dataSource;
  final UserRepository _userRepository;
  // final TodoRepository _todoRepository;

  ProjectRepositoryImpl({
    required ProjectDataSource dataSource,
    required UserRepository userRepository,
    // required TodoRepository todoRepository,
  }) : _dataSource = dataSource,
       _userRepository = userRepository;
  // _todoRepository = todoRepository;

  @override
  Future<Result<List<Project>>> fetchProjectsByUser(UserEntity user) async {
    final dtoResult = await _dataSource.getProjectsByUserId(user.id);

    return switch (dtoResult) {
      Ok(value: final dtos) => await _mapDtosToEntities(dtos),
      Error(:final error) => Result.error(error),
    };
  }

  Future<Result<List<Project>>> _mapDtosToEntities(
    List<ProjectDto> dtos,
  ) async {
    try {
      final projects = await Future.wait(
        dtos.map((dto) async {
          // 1. 멤버 ID 가져오기
          final memberIdsResult = await _dataSource.getMemberIdsByProjectId(
            dto.id,
          );
          if (memberIdsResult is! Ok<List<String>>) return null;
          final memberIds = memberIdsResult.value;

          // 2. 멤버 정보 가져오기
          final membersResult = await _userRepository.getUsersByIds(memberIds);
          if (membersResult is! Ok<List<UserEntity>>) return null;
          final members = membersResult.value;

          // 3. 투두 정보 가져오기 (현재 생략)
          // final todosResult = await _todoRepository.getTodosByIds(dto.todoIds);
          // if (todosResult is! Ok<List<Todo>>) return null;
          // final todos = (todosResult as Ok<List<Todo>>).value;

          // 4. Owner 찾기
          final owner = members.firstWhere(
            (m) => m.id == dto.ownerId,
            orElse: () {
              throw Exception(
                'Owner with ID ${dto.ownerId} not found among project members.',
              );
            },
          );

          // 5. DTO → Entity 매핑
          return dto.toEntity(
            owner: owner,
            members: members,
            todos: [], // 투두 연결 필요 시 주석 해제
          );
        }),
      );

      // 6. null 필터링 후 반환
      final validProjects = projects.whereType<Project>().toList();
      return Result.ok(validProjects);
    } catch (e) {
      return Result.error(Exception('Failed to map ProjectDto to Project: $e'));
    }
  }
}
