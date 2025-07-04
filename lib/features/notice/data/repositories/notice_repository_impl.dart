import 'package:todomodu_app/features/notice/data/datasources/notice_data_source.dart';
import 'package:todomodu_app/features/notice/data/models/notice_dto.dart';
import 'package:todomodu_app/features/notice/domain/entities/notice.dart';
import 'package:todomodu_app/features/notice/domain/repositories/notice_repository.dart';
import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/features/project/domain/repositories/project_repository.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/features/user/data/models/user_dto.dart';
import 'package:todomodu_app/features/user/domain/repositories/user_repository.dart';
import 'package:todomodu_app/shared/types/result.dart';
import 'package:todomodu_app/shared/types/result_extension.dart';

class NoticeRepositoryImpl implements NoticeRepository {
  final NoticeDatasource _dataSource;
  final UserRepository _userRepository;
  final ProjectRepository _projectRepository;

  NoticeRepositoryImpl({
    required NoticeDatasource dataSource,
    required UserRepository userRepository,
    required ProjectRepository projectRepository,
  }) : _dataSource = dataSource,
       _userRepository = userRepository,
       _projectRepository = projectRepository;

  @override
  Future<Result<List<Notice>>> getNoticesByProjects(
    List<Project> projects,
  ) async {
    final projectIds = projects.map((p) => p.id).toList();
    final result = await _dataSource.getNoticesByProjectIds(projectIds);

    return await result.when(
      ok: (dtos) async {
        final allUserIds =
            <String>{
              ...dtos.map((dto) => dto.authorId),
              ...dtos.expand((dto) => dto.checkedUsers),
            }.toList();

        final usersResult = await _userRepository.getUsersByIds(allUserIds);
        return usersResult.when(
          ok: (users) {
            final userMap = {for (var u in users) u.userId: u};
            final notices =
                dtos.map((dto) {
                  final author = userMap[dto.authorId] ?? UserEntity.unknown();
                  final checked =
                      dto.checkedUsers
                          .map((id) => userMap[id] ?? UserEntity.unknown())
                          .toList();
                  return dto.toEntity(
                    author: author,
                    fullCheckedUsers: checked,
                  );
                }).toList();
            return Result.ok(notices);
          },
          error: (e) => Result.error(e),
        );
      },
      error: (e) => Result.error(e),
    );
  }

  @override
  Future<Result<Notice>> getNoticeById({
    required String projectId,
    required String noticeId,
  }) async {
    final result = await _dataSource.getNoticeById(
      projectId: projectId,
      noticeId: noticeId,
    );

    return await result.when(
      ok: (dto) async {
        final allUserIds = <String>{dto.authorId, ...dto.checkedUsers}.toList();

        final usersResult = await _userRepository.getUsersByIds(allUserIds);
        return usersResult.when(
          ok: (users) {
            final userMap = {for (var u in users) u.userId: u};
            final author = userMap[dto.authorId] ?? UserEntity.unknown();
            final checked =
                dto.checkedUsers
                    .map((id) => userMap[id] ?? UserEntity.unknown())
                    .toList();
            return Result.ok(
              dto.toEntity(author: author, fullCheckedUsers: checked),
            );
          },
          error: (e) => Result.error(e),
        );
      },
      error: (e) => Result.error(e),
    );
  }

  @override
  Future<Result<Notice>> createNotice(Notice notice) async {
    final dto = NoticeDto.fromEntity(notice);
    final result = await _dataSource.createNotice(dto);

    return result.when(
      ok:
          (createdDto) => Result.ok(
            createdDto.toEntity(
              author: notice.author,
              fullCheckedUsers: notice.checkedUsers,
            ),
          ),
      error: (e) => Result.error(e),
    );
  }

  @override
  Future<Result<Notice>> updateNotice(Notice notice) async {
    final dto = NoticeDto.fromEntity(notice);
    final result = await _dataSource.updateNotice(dto);

    return result.when(
      ok:
          (updatedDto) => Result.ok(
            updatedDto.toEntity(
              author: notice.author,
              fullCheckedUsers: notice.checkedUsers,
            ),
          ),
      error: (e) => Result.error(e),
    );
  }

  @override
  Future<Result<Notice>> markNoticeAsRead({
    required Notice notice,
    required UserEntity user,
  }) async {
    final dto = NoticeDto.fromEntity(notice);
    final userDto = UserDto.fromEntity(user);
    final result = await _dataSource.markNoticeAsRead(
      noticeDto: dto,
      userDto: userDto,
    );

    return result.when(
      ok: (updatedDto) {
        final newCheckedUsers = [...notice.checkedUsers, user];
        return Result.ok(
          updatedDto.toEntity(
            author: notice.author,
            fullCheckedUsers: newCheckedUsers,
          ),
        );
      },
      error: (e) => Result.error(e),
    );
  }

  @override
  Stream<Result<List<Notice>>> watchNoticesForProjects({
    required List<Project> projects,
  }) {
    final projectIds = projects.map((p) => p.id).toList();
    return _dataSource.watchNoticesByProjectIds(projectIds).asyncMap((
      result,
    ) async {
      return await result.when(
        ok: (dtos) async {
          final allUserIds =
              <String>{
                ...dtos.map((dto) => dto.authorId),
                ...dtos.expand((dto) => dto.checkedUsers),
              }.toList();

          final usersResult = await _userRepository.getUsersByIds(allUserIds);
          return usersResult.when(
            ok: (users) {
              final userMap = {for (var u in users) u.userId: u};
              final notices =
                  dtos.map((dto) {
                    final author =
                        userMap[dto.authorId] ?? UserEntity.unknown();
                    final checked =
                        dto.checkedUsers
                            .map((id) => userMap[id] ?? UserEntity.unknown())
                            .toList();
                    return dto.toEntity(
                      author: author,
                      fullCheckedUsers: checked,
                    );
                  }).toList();
              return Result.ok(notices);
            },
            error: (e) => Result.error(e),
          );
        },
        error: (e) => Result.error(e),
      );
    });
  }

  @override
  Stream<Result<List<Notice>>> watchNoticesForProject({
    required Project project,
  }) {
    return _dataSource.watchNoticesByProjectId(project.id).asyncMap((
      result,
    ) async {
      return await result.when(
        ok: (dtos) async {
          final allUserIds =
              <String>{
                ...dtos.map((dto) => dto.authorId),
                ...dtos.expand((dto) => dto.checkedUsers),
              }.toList();

          final usersResult = await _userRepository.getUsersByIds(allUserIds);
          return usersResult.when(
            ok: (users) {
              final userMap = {for (var u in users) u.userId: u};
              final notices =
                  dtos.map((dto) {
                    final author =
                        userMap[dto.authorId] ?? UserEntity.unknown();
                    final checked =
                        dto.checkedUsers
                            .map((id) => userMap[id] ?? UserEntity.unknown())
                            .toList();
                    return dto.toEntity(
                      author: author,
                      fullCheckedUsers: checked,
                    );
                  }).toList();
              return Result.ok(notices);
            },
            error: (e) => Result.error(e),
          );
        },
        error: (e) => Result.error(e),
      );
    });
  }

  @override
  Stream<Result<List<Notice>>> watchNoticesForUser({required UserEntity user}) {
    return _projectRepository.watchProjectIdsByUser(user).asyncExpand((
      projectIds,
    ) {
      return _dataSource.watchNoticesByProjectIds(projectIds).asyncMap((
        result,
      ) async {
        return await result.when(
          ok: (dtos) async {
            final allUserIds =
                <String>{
                  ...dtos.map((dto) => dto.authorId),
                  ...dtos.expand((dto) => dto.checkedUsers),
                }.toList();

            final usersResult = await _userRepository.getUsersByIds(allUserIds);
            return usersResult.when(
              ok: (users) {
                final userMap = {for (var u in users) u.userId: u};
                final notices =
                    dtos.map((dto) {
                      final author =
                          userMap[dto.authorId] ?? UserEntity.unknown();
                      final checked =
                          dto.checkedUsers
                              .map((id) => userMap[id] ?? UserEntity.unknown())
                              .toList();
                      return dto.toEntity(
                        author: author,
                        fullCheckedUsers: checked,
                      );
                    }).toList();
                return Result.ok(notices);
              },
              error: (e) => Result.error(e),
            );
          },
          error: (e) => Result.error(e),
        );
      });
    });
  }

  @override
  Future<Result<Notice>> fetchNoticebyId({
    required String projectId,
    required String noticeId,
  }) {
    return getNoticeById(projectId: projectId, noticeId: noticeId);
  }

  @override
  Future<Result<List<Notice>>> fetchNoticesbyProjects(List<Project> projects) {
    return getNoticesByProjects(projects);
  }

  @override
  Stream<List<Notice>> watchNoticesByProjectIds(List<String> ids) {
    return _dataSource.watchNoticesByProjectIds(ids).asyncMap((result) async {
      if (result is! Result<List<NoticeDto>>) {
        return []; // 예외 상황 방어 코드
      }
      return await result.when(
        ok: (dtos) async {
          final allUserIds = <String>{
            ...dtos.map((dto) => dto.authorId),
            ...dtos.expand((dto) => dto.checkedUsers),
          };

          final usersResult = await _userRepository.getUsersByIds(
            allUserIds.toList(),
          );
          return usersResult.when(
            ok: (users) {
              final userMap = {for (var u in users) u.userId: u};
              return dtos.map((dto) {
                final author = userMap[dto.authorId] ?? UserEntity.unknown();
                final checkedUsers =
                    dto.checkedUsers
                        .map((id) => userMap[id] ?? UserEntity.unknown())
                        .toList();

                return dto.toEntity(
                  author: author,
                  fullCheckedUsers: checkedUsers,
                );
              }).toList();
            },
            error: (_) => [],
          );
        },
        error: (_) => [],
      );
    });
  }
}
