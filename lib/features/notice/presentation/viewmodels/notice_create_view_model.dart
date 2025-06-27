import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/notice/domain/entities/notice.dart';
import 'package:todomodu_app/features/notice/domain/usecase/create_notice_usecase.dart';
import 'package:todomodu_app/features/notice/presentation/models/notice_create_model.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/shared/types/result.dart';
import 'package:todomodu_app/shared/types/result_extension.dart';

class NoticeCreateViewModel extends StateNotifier<NoticeCreateModel> {
  final CreateNoticeUsecase _createNoticeUsecase;

  NoticeCreateViewModel({
    required CreateNoticeUsecase createNoticeUsecase,
    required String projectId,
  }) : _createNoticeUsecase = createNoticeUsecase,
       super(NoticeCreateModel(projectId: projectId));

  void setTitle(String value) {
    state = state.copyWith(title: value);
  }

  void setContent(String value) {
    state = state.copyWith(content: value);
  }

  Future<Result<Notice>> submit(UserEntity currentUser) async {
    state = state.copyWith(isSubmitting: true, error: null);

    final notice = state.toEntity(
      id: '',
      checkedUsers: [currentUser],
      createdAt: DateTime.now(),
    );

    final result = await _createNoticeUsecase.execute(notice);

    return result.when(
      ok: (createdNotice) {
        state = state.copyWith(isSubmitting: false);
        return Result.ok(createdNotice);
      },
      error: (e) {
        state = state.copyWith(isSubmitting: false, error: e.toString());
        return Result.error(e);
      },
    );
  }
}
