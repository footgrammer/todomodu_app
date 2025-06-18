import 'package:todomodu_app/features/notice/domain/entities/notice.dart';
import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/shared/types/result.dart';

abstract interface class NoticeRepository {
  Future<Result<Notice>> createNotice(Notice notice);

  Future<Result<List<Notice>>> fetchNoticesbyProjects(
    List<Project> projects,
  );

  Future<Result<Notice>> fetchNoticebyId({
    required String projectId,
    required String noticeId,
  });

  Future<Result<Notice>> updateNotice(Notice notice);

  Future<Result<Notice>> markNoticeAsRead({required Notice notice, required UserEntity user});

  
}
