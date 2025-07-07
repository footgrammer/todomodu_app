import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/notice/domain/entities/notice.dart';
import 'package:todomodu_app/features/notice/domain/usecase/mark_notice_as_read_usecase.dart';
import 'package:todomodu_app/features/notice/domain/usecase/watch_notice_by_project_id_usecase.dart';
import 'package:todomodu_app/features/notice/presentation/providers/notice_providers.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/features/user/presentation/providers/user_providers.dart';
import 'package:todomodu_app/shared/types/result_extension.dart';

class NoticeListForProjectViewModel
    extends AutoDisposeFamilyAsyncNotifier<List<Notice>, String> {
  late final WatchNoticesByProjectIdUsecase _watchUsecase;
  late final MarkNoticeAsReadUsecase _markAsReadUsecase;
  StreamSubscription<List<Notice>>? _noticeSub;

  UserEntity? _currentUser; // ✅ 1. currentUser 저장용 필드 추가

  UserEntity? get currentUser => _currentUser; // 외부 접근용 getter

  @override
  FutureOr<List<Notice>> build(String projectId) async {
    _watchUsecase = ref.read(watchNoticesByProjectIdUsecaseProvider);
    _markAsReadUsecase = ref.read(markNoticeAsReadUsecaseProvider);

    _currentUser = await ref.read(userProvider.future); // ✅ 2. 비동기로 유저 초기화

    _noticeSub = _watchUsecase
        .execute(projectId: projectId)
        .listen(
          (notices) {
            state = AsyncData(notices);
          },
          onError: (e, st) {
            state = AsyncError(e, st);
          },
        );

    ref.onDispose(() => _noticeSub?.cancel());
    return const [];
  }

  Future<void> markAsRead(Notice notice) async {
    final user = _currentUser;
    if (user == null) return;

    final result = await _markAsReadUsecase.execute(notice: notice, user: user);

    result.when(
      ok: (updated) {
        final current = state.value ?? [];
        final updatedList =
            current.map((n) => n.id == updated.id ? updated : n).toList();
        state = AsyncData(updatedList);
      },
      error: (e) => print('❌ markAsRead 실패: $e'),
    );
  }
}
