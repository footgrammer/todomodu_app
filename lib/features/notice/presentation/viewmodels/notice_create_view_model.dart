import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/notice/domain/entities/notice.dart';
import 'package:todomodu_app/features/notice/domain/usecase/create_notice_usecase.dart';
import 'package:todomodu_app/features/notice/presentation/models/notice_create_model.dart';
import 'package:todomodu_app/shared/types/result.dart';

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

  Future<Result<Notice>> submit() async {
    state = state.copyWith(isSubmitting: true, error: null);
    print(state.projectId);

    final notice = state.toEntity(
      id: '', // Firestore에서 자동 생성되도록 빈 값
      
      createdAt: DateTime.now(),
    );

    final result = await _createNoticeUsecase.execute(notice);
    
    switch (result) {
      case Ok(value: final createdNotice):
        print('ok');
        state = state.copyWith(isSubmitting: false);
        return Result.ok(createdNotice);
      case Error(:final error):
        print('error');
        state = state.copyWith(isSubmitting: false, error: error.toString());
        print(state.error);
        return Result.error(error);
    }
  }
}
