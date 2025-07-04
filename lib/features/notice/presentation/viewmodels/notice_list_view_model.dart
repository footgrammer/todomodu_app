import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/notice/domain/entities/notice.dart';
import 'package:todomodu_app/features/notice/domain/usecase/mark_notice_as_read_usecase.dart';
import 'package:todomodu_app/features/notice/domain/usecase/watch_notices_by_simple_projects_usecase.dart';
import 'package:todomodu_app/features/notice/presentation/models/notice_list_model.dart';
import 'package:todomodu_app/features/notice/presentation/providers/notice_providers.dart';
import 'package:todomodu_app/features/project/domain/entities/simple_project_info.dart';
import 'package:todomodu_app/features/project/domain/usecases/watch_simple_project_by_user_usecase.dart';
import 'package:todomodu_app/features/project/presentation/providers/project_providers.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/features/user/presentation/providers/user_providers.dart';
import 'package:todomodu_app/shared/types/result_extension.dart';

class NoticeListViewModel extends AutoDisposeAsyncNotifier<NoticeListModel> {
  late final WatchSimpleProjectsByUserUsecase _watchProjectsUsecase;
  late final WatchNoticesBySimpleProjectsUsecase _watchNoticesUsecase;
  late final MarkNoticeAsReadUsecase _markAsReadUsecase;

  StreamSubscription<List<SimpleProjectInfo>>? _projectSub;
  StreamSubscription<List<Notice>>? _noticeSub;

  @override
  FutureOr<NoticeListModel> build() {
    _watchProjectsUsecase = ref.read(watchSimpleProjectsByUserUsecaseProvider);
    _watchNoticesUsecase = ref.read(watchNoticesByProjectIdsUsecaseProvider);
    _markAsReadUsecase = ref.read(markNoticeAsReadUsecase);

    final userAsync = ref.watch(userProvider);
    if (userAsync is! AsyncData<UserEntity>) {
      return NoticeListModel.initial();
    }

    final user = userAsync.value;

    _projectSub = _watchProjectsUsecase.execute(user: user).listen((projects) {
      // 상태에 프로젝트 반영
      state = AsyncData(
        (state.value ?? NoticeListModel.initial()).copyWith(
          projects: projects,
          selectedProjects: projects,
        ),
      );

      // 이전 공지 스트림 해제
      _noticeSub?.cancel();

      // 새로운 프로젝트 기준 공지사항 구독
      _noticeSub = _watchNoticesUsecase.execute(projects: projects).listen((
        notices,
      ) {
        state = AsyncData(
          (state.value ?? NoticeListModel.initial()).copyWith(
            notices: notices,
            selectedNotices: notices,
            isLoading: false,
          ),
        );
      });
    });

    ref.onDispose(() {
      _projectSub?.cancel();
      _noticeSub?.cancel();
    });

    return NoticeListModel.initial().copyWith(isLoading: true);
  }

  void toggleProjectFilter(SimpleProjectInfo project) {
    final current = state.value!;
    final selected = [...current.selectedProjects];

    if (selected.contains(project)) {
      selected.remove(project);
    } else {
      selected.add(project);
    }

    final filteredNotices = current.notices
        .where((n) => selected.any((p) => p.id == n.projectId))
        .toList();

    state = AsyncData(
      current.copyWith(
        selectedProjects: selected,
        selectedNotices: filteredNotices,
      ),
    );
  }

  Future<void> markNoticeAsRead(Notice notice, UserEntity user) async {
    final result = await _markAsReadUsecase.execute(notice: notice, user: user);

    result.when(
      ok: (updatedNotice) {
        final newNotices = state.value!.notices.map((n) {
          return n.id == updatedNotice.id ? updatedNotice : n;
        }).toList();

        final newSelected = state.value!.selectedNotices.map((n) {
          return n.id == updatedNotice.id ? updatedNotice : n;
        }).toList();

        state = AsyncData(
          state.value!.copyWith(
            notices: newNotices,
            selectedNotices: newSelected,
          ),
        );
      },
      error: (e) {
        print('⚠️ markNoticeAsRead 실패: $e');
      },
    );
  }
}
