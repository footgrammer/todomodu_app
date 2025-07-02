import 'dart:developer';

import 'package:todomodu_app/features/notice/data/datasources/notice_data_source.dart';
import 'package:todomodu_app/features/notice/data/models/notice_dto.dart';
import 'package:todomodu_app/features/notice/domain/entities/notice.dart';
import 'package:todomodu_app/features/notice/domain/repositories/notice_repository.dart';
import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/features/project/domain/repositories/project_repository.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/features/user/domain/repositories/user_repository.dart';
import 'package:todomodu_app/shared/types/result.dart';
import 'package:todomodu_app/shared/types/result_extension.dart';

class NoticeRepositoryImpl implements NoticeRepository {
  final NoticeDatasource _datasource;
  final UserRepository _userRepository;
  final ProjectRepository _projectRepository;

  NoticeRepositoryImpl({
    required NoticeDatasource datasource,
    required UserRepository userRepository,
    required ProjectRepository projectRepository,
  }) : _datasource = datasource,
       _userRepository = userRepository,
       _projectRepository = projectRepository;

  @override
  Future<Result<Notice>> createNotice(Notice notice) async {
    final result = await _datasource.createNotice(NoticeDto.fromEntity(notice));

    return await result.when(
      ok: (dto) async {
        final checkedUsersResult = await _userRepository.getUsersByIds(
          dto.checkedUsers,
        );
        final authorResult = await _userRepository.getUserFutureById(
          dto.authorId,
        );

        return checkedUsersResult.when(
          ok:
              (checkedUsers) => authorResult.when(
                ok:
                    (author) => Result.ok(
                      dto.toEntity(
                        fullCheckedUsers: checkedUsers,
                        author: author,
                      ),
                    ),
                error: Result.error,
              ),
          error: Result.error,
        );
      },
      error: Result.error,
    );
  }

  @override
  Future<Result<Notice>> fetchNoticebyId({
    required String projectId,
    required String noticeId,
  }) async {
    final result = await _datasource.getNoticeById(
      projectId: projectId,
      noticeId: noticeId,
    );

    return await result.when(
      ok: (dto) async {
        final usersResult = await _userRepository.getUsersByIds(
          dto.checkedUsers,
        );
        final authorResult = await _userRepository.getUserFutureById(
          dto.authorId,
        );

        return usersResult.when(
          ok:
              (users) => authorResult.when(
                ok:
                    (author) => Result.ok(
                      dto.toEntity(fullCheckedUsers: users, author: author),
                    ),
                error: Result.error,
              ),
          error: Result.error,
        );
      },
      error: Result.error,
    );
  }

  @override
  Future<Result<List<Notice>>> fetchNoticesbyProjects(
    List<Project> projects,
  ) async {
    final result = await _datasource.getNoticesByProjectIds(
      projects.map((e) => e.id).toList(),
    );

    return await result.when(
      ok: (dtoList) async {
        try {
          final futures =
              dtoList.map((dto) async {
                final checkedUsersResult = await _userRepository.getUsersByIds(
                  dto.checkedUsers,
                );
                final authorResult = await _userRepository.getUserFutureById(
                  dto.authorId,
                );

                return checkedUsersResult.when(
                  ok:
                      (users) => authorResult.when(
                        ok:
                            (author) => dto.toEntity(
                              fullCheckedUsers: users,
                              author: author,
                            ),
                        error:
                            (e) =>
                                throw Exception('작성자 조회 실패: ${dto.authorId}'),
                      ),
                  error: (e) => throw Exception('유저 정보 조회 실패: ${dto.id}'),
                );
              }).toList();

          final notices = await Future.wait(futures);
          return Result.ok(notices);
        } catch (e) {
          return Result.error(Exception('예외 발생: $e'));
        }
      },
      error: Result.error,
    );
  }

  @override
  Future<Result<Notice>> markNoticeAsRead({
    required Notice notice,
    required UserEntity user,
  }) async {
    log('mark');

    if (notice.checkedUsers.any((u) => u.userId == user.userId)) {
      return Result.ok(notice);
    }

    final updatedNotice = notice.copyWith(
      checkedUsers: [...notice.checkedUsers, user],
    );

    final result = await _datasource.updateNotice(
      NoticeDto.fromEntity(updatedNotice),
    );

    return await result.when(
      ok: (dto) async {
        final userResult = await _userRepository.getUsersByIds(
          dto.checkedUsers,
        );
        final authorResult = await _userRepository.getUserFutureById(
          dto.authorId,
        );

        return userResult.when(
          ok:
              (users) => authorResult.when(
                ok:
                    (author) => Result.ok(
                      dto.toEntity(fullCheckedUsers: users, author: author),
                    ),
                error: Result.error,
              ),
          error: Result.error,
        );
      },
      error: Result.error,
    );
  }

  @override
  Future<Result<Notice>> updateNotice(Notice notice) async {
    final result = await _datasource.updateNotice(NoticeDto.fromEntity(notice));

    return await result.when(
      ok: (dto) async {
        final authorResult = await _userRepository.getUserFutureById(
          dto.authorId,
        );

        return authorResult.when(
          ok:
              (author) => Result.ok(
                dto.toEntity(
                  fullCheckedUsers: notice.checkedUsers,
                  author: author,
                ),
              ),
          error: Result.error,
        );
      },
      error: Result.error,
    );
  }

  @override
  Stream<Result<List<Notice>>> watchNoticesForUser({
    required UserEntity user,
  }) async* {
    try {
      final projectResult = await _projectRepository.fetchProjectsByUser(user);

      if (projectResult is! Ok<List<Project>>) {
        yield Result.error(Exception('프로젝트 조회 실패'));
        return;
      }

      final projects = projectResult.value;
      if (projects.isEmpty) {
        yield Result.ok([]);
        return;
      }

      final projectIds = projects.map((p) => p.id).toList();

      yield* _datasource.watchNoticesByProjectIds(projectIds).asyncMap((
        dtoResult,
      ) async {
        return await dtoResult.when(
          ok: (dtoList) async {
            try {
              final futures =
                  dtoList.map((dto) async {
                    final checkedUsersResult = await _userRepository
                        .getUsersByIds(dto.checkedUsers);
                    final authorResult = await _userRepository
                        .getUserFutureById(dto.authorId);

                    return checkedUsersResult.when(
                      ok:
                          (users) => authorResult.when(
                            ok:
                                (author) => dto.toEntity(
                                  fullCheckedUsers: users,
                                  author: author,
                                ),
                            error:
                                (e) =>
                                    throw Exception(
                                      '작성자 조회 실패: ${dto.authorId}',
                                    ),
                          ),
                      error: (e) => throw Exception('체크 유저 조회 실패: ${dto.id}'),
                    );
                  }).toList();

              final notices = await Future.wait(futures);
              return Result.ok(notices);
            } catch (e) {
              return Result.error(Exception('Notice 변환 실패: $e'));
            }
          },
          error: (e) => Result.error(e),
        );
      });
    } catch (e) {
      yield Result.error(Exception('알 수 없는 오류: $e'));
    }
  }
}
