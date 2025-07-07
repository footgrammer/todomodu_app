import 'dart:async';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/notice/domain/entities/notice.dart';
import 'package:todomodu_app/features/notice/presentation/models/notice_list_model.dart';
import 'package:todomodu_app/features/notice/presentation/providers/notice_providers.dart';
import 'package:todomodu_app/features/project/domain/entities/simple_project_info.dart';
import 'package:todomodu_app/features/project/presentation/providers/project_providers.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/features/user/presentation/providers/user_providers.dart';
import 'package:todomodu_app/shared/types/result_extension.dart';

class NoticeListViewModel extends AutoDisposeAsyncNotifier<NoticeListModel> {
  StreamSubscription<List<SimpleProjectInfo>>? _projectSub;
  StreamSubscription<List<Notice>>? _noticeSub;

  @override
  FutureOr<NoticeListModel> build() {
    log('🔁 NoticeListViewModel build 시작');

    final user = ref.watch(userProvider).valueOrNull;
    if (user == null) {
      log('🚫 유저 정보 없음. 초기 모델 반환');
      return NoticeListModel.initial(currentUser: UserEntity.unknown());
    }

    log('✅ 유저 로드됨: ${user.userId}');
    final initial = NoticeListModel.initial(currentUser: user);
    state = AsyncData(initial);

    _projectSub = ref
        .read(watchSimpleProjectsByUserUsecaseProvider)
        .execute(user: user)
        .listen((projects) {
          final current = state.value ?? initial;
          state = AsyncData(
            current.copyWith(
              projects: projects,
              selectedProjects: List<SimpleProjectInfo>.from(projects),
            ),
          );

          _noticeSub?.cancel(); // 기존 구독 해제
          _noticeSub = ref
              .read(watchNoticesBySimpleProjectsUsecaseProvider)
              .execute(projects: projects)
              .listen((notices) {
                log('📩 받은 공지 개수: ${notices.length}');
                final current = state.value ?? initial;
                state = AsyncData(current.copyWith(notices: notices));
              });
        });

    ref.onDispose(() {
      _projectSub?.cancel();
      _noticeSub?.cancel();
    });

    return initial;
  }

  void updateSelectedProjects(List<SimpleProjectInfo> selected) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(current.copyWith(selectedProjects: selected));
  }

  Future<void> markNoticeAsRead(Notice notice) async {
    final user = ref.read(userProvider).requireValue;
    if (user == null) return;

    // 직접 ref.read() 사용
    final result = await ref
        .read(markNoticeAsReadUsecaseProvider)
        .execute(notice: notice, user: user);

    result.when(
      ok: (updated) {
        final current = state.value!;
        final updatedList =
            current.notices
                .map((n) => n.id == updated.id ? updated : n)
                .toList();
        state = AsyncData(current.copyWith(notices: updatedList));
      },
      error: (e) => print('❌ markNoticeAsRead 실패: $e'),
    );
  }
}
