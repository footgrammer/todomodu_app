import 'dart:developer';
import 'package:todomodu_app/features/project/data/datasources/project_data_source.dart';
import 'package:todomodu_app/features/project/data/models/project_dto.dart';
import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/features/project/domain/repositories/project_repository.dart';
import 'package:todomodu_app/features/todo/domain/entities/todo.dart';
import 'package:todomodu_app/features/todo/domain/repositories/todo_repository.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/features/user/domain/repositories/user_repository.dart';
import 'package:todomodu_app/shared/types/result.dart';

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

  /// 기존: 유저별 프로젝트 리스트 조회
  @override
  Future<Result<List<Project>>> fetchProjectsByUser(UserEntity user) async {
    final dtoResult = await _dataSource.getProjectsByUserId(user.userId);

    return switch (dtoResult) {
      Ok(value: final dtos) => await _mapDtosToEntities(dtos),
      Error(:final error) => Result.error(error),
    };
  }

  /// 새로 추가: 단일 projectId 기반 상세 조회(프로젝트 상세 페이지 등)
  @override
  Future<Result<Project>> fetchProjectById(String projectId) async {
    try {
      // 1. 프로젝트 문서 로드
      final dto = await _dataSource.getProjectDtoById(projectId);
      if (dto == null) {
        return Result.error(Exception('Project not found'));
      }

      // 2. 멤버 ID -> 정보 가져오기
      final memberIdsResult = await _dataSource.getMemberIdsByProjectId(
        projectId,
      );
      if (memberIdsResult is! Ok<List<String>>) {
        return Result.error(Exception('Failed to get member IDs'));
      }
      final memberIds = memberIdsResult.value;

      final membersResult = await _userRepository.getUsersByIds(memberIds);
      if (membersResult is! Ok<List<UserEntity>>) {
        return Result.error(Exception('Failed to get user info'));
      }
      final members = membersResult.value;

      // 3. 투두 목록 가져오기
      final todosResult = await _todoRepository.getTodosWithSubtasksByProjectId(
        projectId,
      );
      final todos =
          todosResult is Ok<List<Todo>> ? todosResult.value : <Todo>[];

      //  progress 계산: 모든 subtask 개수 및 완료된 개수 기반
      final allSubtasks = todos.expand((t) => t.subtasks).toList();
      final totalSubs = allSubtasks.length;
      final doneSubs = allSubtasks.where((s) => s.isDone).length;
      final progress = totalSubs == 0 ? 0.0 : doneSubs / totalSubs;

      // 4. owner 할당
      final owner = members.firstWhere(
        (m) => m.userId == dto.ownerId,
        orElse: () => throw Exception('Owner not found'),
      );

      // 5. DTO → Entity 매핑 후 반환
      return Result.ok(
        dto.toEntity(
          owner: owner,
          members: members,
          todos: todos,
        ),
      );
    } catch (e) {
      return Result.error(Exception('fetchProjectById error: $e'));
    }
  }

  /// 기존 리스트 -> Entity 맵핑 보조 메서드 (변경 없음, 단 progress 계산 추가됨)
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

          final membersResult = await _userRepository.getUsersByIds(
            memberIdsResult.value,
          );
          if (membersResult is! Ok<List<UserEntity>>) return null;

          final todosResult = await _todoRepository
              .getTodosWithSubtasksByProjectId(dto.id);

          // 3. 프로젝트별 투두, 서브태스크 정보 가져오기
          if (todosResult is! Ok<List<Todo>>) return null;
          final todos = todosResult.value;

          //  progress 계산 추가
          final allSubtasks = todos.expand((t) => t.subtasks).toList();
          final totalSubs = allSubtasks.length;
          final doneSubs = allSubtasks.where((s) => s.isDone).length;
          final progress = totalSubs == 0 ? 0.0 : doneSubs / totalSubs;

          final owner = membersResult.value.firstWhere(
            (m) => m.userId == dto.ownerId,
            orElse: () => throw Exception('Owner not found'),
          );

          return dto.toEntity(
            owner: owner,
            members: membersResult.value,
            todos: todos,
          );
        }),
      );

      final list = projects.whereType<Project>().toList();
      return Result.ok(list);
    } catch (e) {
      return Result.error(Exception('Mapping error: $e'));
    }
  }

  @override
  Future<void> createProject(Project project) async {
    final projectDto = ProjectDto.fromEntity(project);
    await _dataSource.createProject(projectDto, project.todos);
  }

  @override
  Future<List<Project>> fetchProjectsByUserId(String userId) async {
    final projectDtos = await _dataSource.fetchProjectsByUserId(userId);
    try {
      final projects = await Future.wait(
        projectDtos.map((dto) async {
          // 1. 멤버 ID 가져오기
          final memberIdsResult = await _dataSource.getMemberIdsByProjectId(
            dto.id,
          );
          if (memberIdsResult is! Ok<List<String>>) {
            return null;
          }
          final memberIds = memberIdsResult.value;

          // 2. 멤버 정보 가져오기
          final membersResult = await _userRepository.getUsersByIds(memberIds);
          if (membersResult is! Ok<List<UserEntity>>) {
            return null;
          }
          final members = membersResult.value;

          // 3. 투두 정보 가져오기 (현재 생략)
          final todosResult = await _todoRepository
              .getTodosWithSubtasksByProjectId(dto.id);
          if (todosResult is! Ok<List<Todo>>) {
            return null;
          }
          final todos = todosResult.value;

          // 4. Owner 찾기
          try {
            final owner = members.firstWhere(
              (m) => m.userId == dto.ownerId,
              orElse: () {
                throw Exception(
                  'Owner with ID ${dto.ownerId} not found among project members.',
                );
              },
            );

            final allSubtasks = todos.expand((t) => t.subtasks).toList();
            final totalSubs = allSubtasks.length;
            final doneSubs = allSubtasks.where((s) => s.isDone).length;
            final progress = totalSubs == 0 ? 0.0 : doneSubs / totalSubs;

            // 5. DTO → Entity 매핑
            return dto.toEntity(
              owner: owner,
              members: members,
              todos: todos,
            );
          } catch (e) {
            log(
              '⚠️ Owner 찾기 실패: ${dto.ownerId} not in members for project ${dto.id}',
            );
          }
        }),
      );

      // 6. null 필터링 후 반환
      final validProjects = projects.whereType<Project>().toList();
      return validProjects;
    } catch (e) {
      log('project_repository_impl : fetchProjectsByUserId $e');
      return [];
    }
  }

  @override
  Future<Project?> getProjectByInvitationCode(String code) async {
    final projectDto = await _dataSource.getProjectByInvitationCode(code);
    if (projectDto == null) return null;

    // 1. 멤버 ID 가져오기
    final memberIdsResult = await _dataSource.getMemberIdsByProjectId(
      projectDto.id,
    );
    if (memberIdsResult is! Ok<List<String>>) return null;
    final memberIds = memberIdsResult.value;

    // 2. 멤버 정보 가져오기
    final membersResult = await _userRepository.getUsersByIds(memberIds);
    if (membersResult is! Ok<List<UserEntity>>) return null;
    final members = membersResult.value;

    // 3. 투두 정보 가져오기 (현재 생략)
    final todosResult = await _todoRepository.getTodosWithSubtasksByProjectId(
      projectDto.id,
    );
    if (todosResult is! Ok<List<Todo>>) return null;
    final todos = todosResult.value;

    // 4. Owner 찾기
    final owner = members.firstWhere(
      (m) => m.userId == projectDto.ownerId,
      orElse: () {
        throw Exception(
          'Owner with ID ${projectDto.ownerId} not found among project members.',
        );
      },
    );

    // 멤버/투두 불러오기
    return projectDto.toEntity(
      owner: owner,
      members: members,
      todos: todos,
    );
  }

  @override
  Future<void> addMemberToProject({
    required String projectId,
    required String userId,
  }) async {
    await _dataSource.addMemberToProject(projectId: projectId, userId: userId);
  }

  @override
  Future<void> deleteProject(String projectId) {
    return _dataSource.deleteProject(projectId);
  }
}
