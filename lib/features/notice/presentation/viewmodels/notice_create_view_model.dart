import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/notice/domain/entities/notice.dart';
import 'package:todomodu_app/features/notice/domain/usecase/create_notice_usecase.dart';
import 'package:todomodu_app/features/notice/presentation/models/notice_create_model.dart';
import 'package:todomodu_app/features/notice/presentation/providers/notice_providers.dart';
import 'package:todomodu_app/features/user/presentation/providers/user_providers.dart';
import 'package:todomodu_app/shared/types/result.dart';
import 'package:todomodu_app/shared/types/result_extension.dart';

class NoticeCreateViewModel
    extends FamilyAsyncNotifier<NoticeCreateModel, String> {
  late final CreateNoticeUsecase _createNoticeUsecase;

  @override
  Future<NoticeCreateModel> build(String projectId) async {
    _createNoticeUsecase = ref.read(createNoticeUsecaseProvider);
    final userResult =
        await ref.read(getCurrentUserFutureUsecaseProvider).execute();

    return userResult.when(
      ok: (user) => NoticeCreateModel(projectId: projectId, author: user),
      error: (e) => throw Exception('사용자 정보 조회 실패: $e'),
    );
  }

  void setTitle(String value) {
    state = AsyncData(state.requireValue.copyWith(title: value));
  }

  void setContent(String value) {
    state = AsyncData(state.requireValue.copyWith(content: value));
  }

  Future<Result<Notice>> submit() async {
    final model = state.requireValue;
    state = AsyncData(model.copyWith(isSubmitting: true, error: null));

    final notice = model.toEntity(
      id: '',
      checkedUsers: [model.author],
      createdAt: DateTime.now(),
    );

    final result = await _createNoticeUsecase.execute(notice);

    return result.when(
      ok: (createdNotice) {
        state = AsyncData(model.copyWith(isSubmitting: false));
        return Result.ok(createdNotice);
      },
      error: (e) {
        state = AsyncData(
          model.copyWith(isSubmitting: false, error: e.toString()),
        );
        return Result.error(e);
      },
    );
  }
}
