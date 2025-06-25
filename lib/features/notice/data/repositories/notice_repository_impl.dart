import 'dart:developer';

import 'package:todomodu_app/features/notice/data/datasources/notice_data_source.dart';
import 'package:todomodu_app/features/notice/data/models/notice_dto.dart';
import 'package:todomodu_app/features/notice/domain/entities/notice.dart';
import 'package:todomodu_app/features/notice/domain/repositories/notice_repository.dart';
import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/features/user/domain/repositories/user_repository.dart';
import 'package:todomodu_app/shared/types/result.dart';

class NoticeRepositoryImpl implements NoticeRepository {
  final NoticeDatasource _datasource;
  final UserRepository _userRepository;

  NoticeRepositoryImpl({
    required NoticeDatasource datasource,
    required UserRepository userRepository,
  }) : _datasource = datasource,
       _userRepository = userRepository;

  @override
  Future<Result<Notice>> createNotice(Notice notice) async {
    final result = await _datasource.createNotice(NoticeDto.fromEntity(notice));
    return switch (result) {
      Ok(value: final dto) => Result.ok(dto.toEntity(fullCheckedUsers: [])),
      Error(:final error) => Result.error(error),
    };
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
    return switch (result) {
      Ok(value: final dto) => Result.ok(dto.toEntity(fullCheckedUsers: [])),
      Error(:final error) => Result.error(error),
    };
  }

  @override
  Future<Result<List<Notice>>> fetchNoticesbyProjects(
    List<Project> projects,
  ) async {
    try {
      final result = await _datasource.getNoticesByProjectIds(
        projects.map((e) => e.id).toList(),
      );

      if (result is Error<List<NoticeDto>>) {
        return Result.error(result.error);
      }

      if (result is! Ok<List<NoticeDto>>) {
        return Result.error(Exception('예상치 못한 오류'));
      }

      final dtoList = result.value;

      // ✅ 병렬 처리로 checkedUsers를 가져옴
      final futures =
          dtoList.map((dto) async {
            final userResult = await _userRepository.getUsersByIds(
              dto.checkedUsers,
            );

            if (userResult is! Ok<List<UserEntity>>) {
              throw Exception('유저 정보 조회 실패: ${dto.id}');
            }

            return dto.toEntity(fullCheckedUsers: userResult.value);
          }).toList();

      final notices = await Future.wait(futures);
      return Result.ok(notices);
    } catch (e) {
      return Result.error(Exception('예외 발생: $e'));
    }
  }

  @override
  Future<Result<Notice>> markNoticeAsRead({
    required Notice notice,
    required UserEntity user,
  }) async {
    log('mark');
    // 1. 이미 읽었으면 그대로 반환
    if (notice.checkedUsers.any((u) => u.userId == user.userId)) {
      return Result.ok(notice);
    }

    // 2. checkedUsers 목록에 추가
    final updatedNotice = notice.copyWith(
      checkedUsers: [...notice.checkedUsers, user],
    );

    // 3. Firestore 업데이트
    final result = await _datasource.updateNotice(
      NoticeDto.fromEntity(updatedNotice),
    );

    // 4. 결과 처리
    if (result is! Ok<NoticeDto>) {
      if (result is Error<NoticeDto>) {
        return Result.error(result.error);
      }
      return Result.error(Exception('예상치 못한 오류'));
    }

    final dto = result.value;

    // 5. updated된 checkedUserIds를 기준으로 UserEntity 재조회
    final userResult = await _userRepository.getUsersByIds(dto.checkedUsers);

    if (userResult is! Ok<List<UserEntity>>) {
      return Result.error(Exception('유저 정보 조회 실패'));
    }

    return Result.ok(dto.toEntity(fullCheckedUsers: userResult.value));
  }

  @override
  Future<Result<Notice>> updateNotice(Notice notice) async {
    final result = await _datasource.updateNotice(NoticeDto.fromEntity(notice));
    return switch (result) {
      Ok(value: final dto) => Result.ok(
        dto.toEntity(fullCheckedUsers: notice.checkedUsers),
      ),
      Error(:final error) => Result.error(error),
    };
  }
}
