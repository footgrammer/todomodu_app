import 'package:todomodu_app/features/notice/domain/entities/notice.dart';
import 'package:todomodu_app/features/notice/domain/repositories/notice_repository.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/features/user/domain/repositories/user_repository.dart';
import 'package:todomodu_app/shared/types/result.dart';

class MarkNoticeAsReadUsecase {
  final NoticeRepository _noticeRepository;

  MarkNoticeAsReadUsecase({
    required NoticeRepository noticeRepository,
    required UserRepository userRepository,
  }) : _noticeRepository = noticeRepository;

  Future<Result<Notice>> execute({
    required Notice notice,
    required UserEntity user,
  }) async {
    try {
      return _noticeRepository.markNoticeAsRead(notice: notice, user: user);
    } catch (e) {
      return Result.error(Exception('사용자 정보를 불러올 수 없습니다: $e'));
    }
  }
}
