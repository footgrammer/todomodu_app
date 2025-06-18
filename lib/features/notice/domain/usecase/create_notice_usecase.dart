import 'package:todomodu_app/features/notice/domain/entities/notice.dart';
import 'package:todomodu_app/features/notice/domain/repositories/notice_repository.dart';
import 'package:todomodu_app/shared/types/result.dart';

class CreateNoticeUsecase {
  final NoticeRepository _noticeRepository;
  CreateNoticeUsecase({required NoticeRepository noticeRepository}) : _noticeRepository = noticeRepository;

  Future<Result<Notice>> execute(Notice notice){
    return _noticeRepository.createNotice(notice);
  }
}