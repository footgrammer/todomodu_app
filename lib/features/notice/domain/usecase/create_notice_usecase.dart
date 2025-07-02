import 'package:todomodu_app/features/activity_history/domain/entities/activity_history.dart';
import 'package:todomodu_app/features/activity_history/domain/models/activity_history_payload.dart';
import 'package:todomodu_app/features/activity_history/domain/usecases/log_activity_history_usecase.dart';
import 'package:todomodu_app/features/notice/domain/entities/notice.dart';
import 'package:todomodu_app/features/notice/domain/repositories/notice_repository.dart';
import 'package:todomodu_app/shared/types/result.dart';

class CreateNoticeUsecase {
  final NoticeRepository _noticeRepository;
  final LogActivityHistoryUsecase _logActivityHistoryUsecase;

  CreateNoticeUsecase({
    required NoticeRepository noticeRepository,
    required LogActivityHistoryUsecase logActivityHistoryUsecase,
  }) : _noticeRepository = noticeRepository,
       _logActivityHistoryUsecase = logActivityHistoryUsecase;

  Future<Result<Notice>> execute(Notice notice) async {
    final result = await _noticeRepository.createNotice(notice);

    if (result is Ok<Notice>) {
      final createdNotice = result.value;

      final activity = ActivityHistory(
        id: '', // Firestore에서 자동 생성 시 빈 값 가능
        projectId: createdNotice.projectId,
        createdAt: DateTime.now(),
        payload: ActivityHistoryPayload.noticePosted(
          title: createdNotice.title,
          noticeId: createdNotice.id,
        ),
      );

      await _logActivityHistoryUsecase.execute(activity);
    }

    return result;
  }
}
