import 'package:todomodu_app/features/notice/data/datasources/notice_data_source.dart';
import 'package:todomodu_app/features/notice/data/models/notice_dto.dart';
import 'package:todomodu_app/features/notice/domain/entities/notice.dart';
import 'package:todomodu_app/features/notice/domain/repositories/notice_repository.dart';
import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/shared/types/result.dart';

class NoticeRepositoryImpl implements NoticeRepository {
  final NoticeDatasource _datasource;

  NoticeRepositoryImpl({required NoticeDatasource datasource})
    : _datasource = datasource;

  @override
  Future<Result<Notice>> createNotice(Notice notice) async {
    final result = await _datasource.createNotice(NoticeDto.fromEntity(notice));

    return switch (result) {
      Ok(value: final dto) => Result.ok(
        dto.toEntity(fullCheckedUsers: []),
      ), // ← 필요시 주입
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
      Ok(value: final dto) => Result.ok(
        dto.toEntity(fullCheckedUsers: []),
      ), // ← 필요시 주입
      Error(:final error) => Result.error(error),
    };
  }

  @override
  Future<Result<List<Notice>>> fetchNoticesbyProjects(
    List<Project> projects,
  ) async {
    final result = await _datasource.getNoticesByProjectIds(
      projects.map((e) => e.id).toList(),
    );

    return switch (result) {
      Ok(value: final dtoList) => Result.ok(
        dtoList.map((dto) => dto.toEntity(fullCheckedUsers: [])).toList(),
      ),
      Error(:final error) => Result.error(error),
    };
  }

  @override
  Future<Result<Notice>> markNoticeAsRead({
    required Notice notice,
    required UserEntity user,
  }) async {
    // 이미 읽은 사용자라면 바로 반환
    if (notice.checkedUsers.any((u) => u.userId == user.userId)) {
      return Result.ok(notice);
    }

    // 새로운 사용자 추가
    final updatedNotice = notice.copyWith(
      checkedUsers: [...notice.checkedUsers, user],
    );

    // updateNotice 호출
    final result = await _datasource.updateNotice(
      NoticeDto.fromEntity(updatedNotice),
    );

    return switch (result) {
      Ok(value: final dto) => Result.ok(
        dto.toEntity(fullCheckedUsers: updatedNotice.checkedUsers),
      ),
      Error(:final error) => Result.error(error),
    };
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
