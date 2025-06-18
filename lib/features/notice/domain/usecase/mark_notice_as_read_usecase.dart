import 'package:todomodu_app/features/notice/domain/entities/notice.dart';
import 'package:todomodu_app/features/notice/domain/repositories/notice_repository.dart';
import 'package:todomodu_app/features/user/domain/repositories/user_repository.dart';
import 'package:todomodu_app/shared/types/result.dart';

class MarkNoticeAsReadUsecase {
  final NoticeRepository _noticeRepository;
  final UserRepository _userRepository;

  MarkNoticeAsReadUsecase({
    required NoticeRepository noticeRepository,
    required UserRepository userRepository,
  })  : _noticeRepository = noticeRepository,
        _userRepository = userRepository;

  Future<Result<Notice>> execute({
    required Notice notice,
  }) async {
    try {
      final user = await _userRepository
          .getCurrentUser()
          .firstWhere((user) => user != null);

      return _noticeRepository.markNoticeAsRead(
        notice: notice,
        user: user!,
      );
    } catch (e) {
      return Result.error(Exception('사용자 정보를 불러올 수 없습니다: $e'));
    }
  }
}


