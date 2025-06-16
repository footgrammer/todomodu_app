import 'package:todomodu_app/features/notice/domain/entities/notice.dart';
import 'package:todomodu_app/features/notice/domain/repositories/notice_repository.dart';
import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/shared/types/result.dart';

class RetrieveNoticesByProjectsUsecase {
  final NoticeRepository _noticeRepository;
  RetrieveNoticesByProjectsUsecase({
    required NoticeRepository noticeRepository,
  }) : _noticeRepository = noticeRepository;

  Future<Result<List<Notice>>> execute(List<Project> projects) {
    return _noticeRepository.fetchNoticesbyProjects(projects);
  }
}
