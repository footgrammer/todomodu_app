import 'dart:core';
import 'package:todomodu_app/features/notice/data/models/notice_dto.dart';
import 'package:todomodu_app/features/user/data/models/user_dto.dart';
import 'package:todomodu_app/shared/types/result.dart';

abstract interface class NoticeDatasource {
  Future<Result<NoticeDto>> getNoticeById({
    required String projectId,
    required String noticeId,
  });
  Future<Result<List<NoticeDto>>> getNoticesByProjectIds(List<String> ids);

  Future<Result<NoticeDto>> createNotice(NoticeDto notice);

  Future<Result<NoticeDto>> markNoticeAsRead({required NoticeDto noticeDto, required UserDto userDto});

  Future<Result<NoticeDto>> updateNotice(NoticeDto noticeDto);

  Stream<Result<List<NoticeDto>>> watchNoticesByProjectIds(List<String> projectIds);

  Stream<Result<List<NoticeDto>>> watchNoticesByProjectId(String projectId);

}
