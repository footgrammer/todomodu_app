import 'package:todomodu_app/features/notice/domain/entities/notice.dart';
import 'package:todomodu_app/features/notice/domain/repositories/notice_repository.dart';

class WatchNoticesByProjectIdUsecase {
  final NoticeRepository _noticeRepository;

  WatchNoticesByProjectIdUsecase(NoticeRepository noticeRepository) : _noticeRepository = noticeRepository;

  Stream<List<Notice>> execute({required String projectId}) {
    return _noticeRepository.watchNoticesByProjectId(projectId);
  }
}
