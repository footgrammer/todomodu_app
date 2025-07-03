import 'dart:developer';

import 'package:todomodu_app/features/project/data/datasources/project_data_source.dart';
import 'package:todomodu_app/features/project/data/models/project_dto.dart';
import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/features/project/domain/entities/simple_project_info.dart';
import 'package:todomodu_app/features/project/domain/repositories/project_repository.dart';
import 'package:todomodu_app/features/todo/domain/entities/todo.dart';
import 'package:todomodu_app/features/todo/domain/repositories/todo_repository.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/features/user/domain/repositories/user_repository.dart';
import 'package:todomodu_app/shared/types/result.dart';
import 'package:todomodu_app/shared/types/result_extension.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectDataSource _dataSource;
  final UserRepository _userRepository;
  final TodoRepository _todoRepository;

  ProjectRepositoryImpl({
    required ProjectDataSource dataSource,
    required UserRepository userRepository,
    required TodoRepository todoRepository,
  }) : _dataSource = dataSource,
       _userRepository = userRepository,
       _todoRepository = todoRepository;

  @override
  Future<Result<List<Project>>> fetchProjectsByUser(UserEntity user) async {
    final dtoResult = await _dataSource.getProjectsByUserId(user.userId);
    return await dtoResult.when(
      ok: (dtos) => _mapDtosToEntities(dtos),
      error: (e) => Result.error(e),
    );
  }

  @override
  Future<Result<Project>> fetchProjectById(String projectId) async {
    try {
      final dto = await _dataSource.getProjectDtoById(projectId);
      if (dto == null) return Result.error(Exception('Project not found'));

      final memberIdsResult = await _dataSource.getMemberIdsByProjectId(
        projectId,
      );
      final memberIds = memberIdsResult.when(
        ok: (value) => value,
        error: (_) => null,
      );
      if (memberIds == null) {
        return Result.error(Exception('Failed to get member IDs'));
      }

      final membersResult = await _userRepository.getUsersByIds(memberIds);
      final members = membersResult.when(
        ok: (value) => value,
        error: (_) => null,
      );
      if (members == null) {
        return Result.error(Exception('Failed to get user info'));
      }

      final todosResult = await _todoRepository.getTodosWithSubtasksByProjectId(
        projectId,
      );
      final todos = todosResult.when(
        ok: (value) => value,
        error: (_) => <Todo>[], // ✅ 타입 명시
      );

      final owner = members.firstWhere(
        (m) => m.userId == dto.ownerId,
        orElse: () => UserEntity.unknown(),
      );

      return Result.ok(
        dto.toEntity(owner: owner, members: members, todos: todos),
      );
    } catch (e) {
      return Result.error(Exception('fetchProjectById error: $e'));
    }
  }

  @override
  Future<List<Project>> fetchProjectsByUserId(String userId) async {
    final dtos = await _dataSource.fetchProjectsByUserId(userId);
    try {
      final projects = await Future.wait(
        dtos.map((dto) async {
          final memberIdsResult = await _dataSource.getMemberIdsByProjectId(
            dto.id,
          );
          final memberIds = memberIdsResult.when(
            ok: (value) => value,
            error: (_) => null,
          );
          if (memberIds == null) return null;

          final membersResult = await _userRepository.getUsersByIds(memberIds);
          final members = membersResult.when(
            ok: (value) => value,
            error: (_) => null,
          );
          if (members == null) return null;

          final todosResult = await _todoRepository
              .getTodosWithSubtasksByProjectId(dto.id);
          final todos = todosResult.when(
            ok: (value) => value,
            error: (_) => null,
          );
          if (todos == null) return null;

          final allSubtasks = todos.expand((t) => t.subtasks).toList();
          final progress =
              allSubtasks.isEmpty
                  ? 0.0
                  : allSubtasks.where((s) => s.isDone).length /
                      allSubtasks.length;

          try {
            final owner = members.firstWhere(
              (m) => m.userId == dto.ownerId,
              orElse: () => UserEntity.unknown(),
            );
            return dto.toEntity(owner: owner, members: members, todos: todos);
          } catch (e) {
            log('⚠️ Owner not found in project ${dto.id}');
            return null;
          }
        }),
      );

      return projects.whereType<Project>().toList();
    } catch (e) {
      log('fetchProjectsByUserId error: $e');
      return [];
    }
  }

  @override
  Future<void> createProject(Project project) async {
    final dto = ProjectDto.fromEntity(project);
    await _dataSource.createProject(dto, project.todos);
  }

  @override
  Future<void> deleteProject(String projectId) {
    return _dataSource.deleteProject(projectId);
  }

  @override
  Future<Project?> getProjectByInvitationCode(String code) async {
    final dto = await _dataSource.getProjectByInvitationCode(code);
    if (dto == null) return null;

    final memberIdsResult = await _dataSource.getMemberIdsByProjectId(dto.id);
    final memberIds = memberIdsResult.when(
      ok: (value) => value,
      error: (_) => null,
    );
    if (memberIds == null) return null;

    final membersResult = await _userRepository.getUsersByIds(memberIds);
    final members = membersResult.when(
      ok: (value) => value,
      error: (_) => null,
    );
    if (members == null) return null;

    final todosResult = await _todoRepository.getTodosWithSubtasksByProjectId(
      dto.id,
    );
    final todos = todosResult.when(ok: (value) => value, error: (_) => null);
    if (todos == null) return null;

    final owner = members.firstWhere(
      (m) => m.userId == dto.ownerId,
      orElse: () => UserEntity.unknown(),
    );

    return dto.toEntity(owner: owner, members: members, todos: todos);
  }

  @override
  Future<void> addMemberToProject({
    required String projectId,
    required String userId,
  }) async {
    await _dataSource.addMemberToProject(projectId: projectId, userId: userId);
  }

  @override
  Future<Result<List<SimpleProjectInfo>>> getSimpleProjectInfosByIds(
    List<String> ids,
  ) async {
    if (ids.isEmpty) return Result.ok([]);

    final result = await _dataSource.getProjectDtosByIds(ids);
    return result.when(
      ok:
          (dtos) => Result.ok(
            dtos
                .map((dto) => SimpleProjectInfo(id: dto.id, title: dto.title))
                .toList(),
          ),
      error: (e) => Result.error(e),
    );
  }

  @override
  Stream<List<String>> watchProjectIdsByUser(UserEntity user) {
    return _dataSource.watchProjectIdsByUserId(user.userId);
  }

  /// 내부 전용: 여러 DTO → Entity 변환
  Future<Result<List<Project>>> _mapDtosToEntities(
    List<ProjectDto> dtos,
  ) async {
    try {
      final projects = await Future.wait(
        dtos.map((dto) async {
          final memberIdsResult = await _dataSource.getMemberIdsByProjectId(
            dto.id,
          );
          final memberIds = memberIdsResult.when(
            ok: (value) => value,
            error: (_) => null,
          );
          if (memberIds == null) return null;

          final membersResult = await _userRepository.getUsersByIds(memberIds);
          final members = membersResult.when(
            ok: (value) => value,
            error: (_) => null,
          );
          if (members == null) return null;

          final todosResult = await _todoRepository
              .getTodosWithSubtasksByProjectId(dto.id);
          final todos = todosResult.when(
            ok: (value) => value,
            error: (_) => null,
          );
          if (todos == null) return null;

          final allSubtasks = todos.expand((t) => t.subtasks).toList();
          final progress =
              allSubtasks.isEmpty
                  ? 0.0
                  : allSubtasks.where((s) => s.isDone).length /
                      allSubtasks.length;

          final owner = members.firstWhere(
            (m) => m.userId == dto.ownerId,
            orElse: () => UserEntity.unknown(),
          );

          return dto.toEntity(owner: owner, members: members, todos: todos);
        }),
      );

      return Result.ok(projects.whereType<Project>().toList());
    } catch (e) {
      return Result.error(Exception('Mapping error: $e'));
    }
  }
}
