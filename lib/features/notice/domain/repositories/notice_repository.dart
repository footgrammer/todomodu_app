import 'package:todomodu_app/features/notice/domain/entities/notice.dart';
import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/shared/types/result.dart';

abstract interface class NoticeRepository {
  /// 단일 공지 조회
  Future<Result<Notice>> getNoticeById({
    required String projectId,
    required String noticeId,
  });

  /// 여러 프로젝트의 공지 조회 (1회성)
  Future<Result<List<Notice>>> getNoticesByProjects(List<Project> projects);

  /// 단일 공지 생성
  Future<Result<Notice>> createNotice(Notice notice);

  /// 공지 업데이트
  Future<Result<Notice>> updateNotice(Notice notice);

  /// 공지를 읽음 처리
  Future<Result<Notice>> markNoticeAsRead({
    required Notice notice,
    required UserEntity user,
  });

  /// 특정 프로젝트의 공지 스트림
  Stream<Result<List<Notice>>> watchNoticesForProject({
    required Project project,
  });

  /// 여러 프로젝트의 공지 스트림
  Stream<Result<List<Notice>>> watchNoticesForProjects({
    required List<Project> projects,
  });

  /// 현재 사용자가 속한 모든 프로젝트에 대해 공지 스트림 제공
  Stream<Result<List<Notice>>> watchNoticesForUser({required UserEntity user});

  /// `getNoticeById`와 동일, 대체용
  Future<Result<Notice>> fetchNoticebyId({
    required String projectId,
    required String noticeId,
  });

  /// `getNoticesByProjects`와 동일, 대체용
  Future<Result<List<Notice>>> fetchNoticesbyProjects(List<Project> projects);

  Stream<List<Notice>> watchNoticesByProjectIds(List<String> ids);

  Stream<List<Notice>> watchNoticesByProjectId(String projectId);
}
