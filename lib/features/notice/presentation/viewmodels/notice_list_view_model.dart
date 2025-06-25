import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/notice/domain/entities/notice.dart';
import 'package:todomodu_app/features/notice/domain/usecase/retrieve_notices_by_projects_usecase.dart';
import 'package:todomodu_app/features/notice/domain/usecase/mark_notice_as_read_usecase.dart';
import 'package:todomodu_app/features/notice/presentation/models/notice_list_model.dart';
import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/features/project/domain/usecases/fetch_projects_by_user_id_usecase.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/shared/types/result.dart';

class NoticeListViewModel extends StateNotifier<NoticeListModel> {
  final RetrieveNoticesByProjectsUsecase _retrieveUsecase;
  final MarkNoticeAsReadUsecase _markAsReadUsecase;
  final FetchProjectsByUserUsecase _fetchProjectsUsecase;

  NoticeListViewModel({
    required RetrieveNoticesByProjectsUsecase retrieveUsecase,
    required MarkNoticeAsReadUsecase markAsReadUsecase,
    required FetchProjectsByUserUsecase fetchProjectsUsecase,
  }) : _retrieveUsecase = retrieveUsecase,
       _markAsReadUsecase = markAsReadUsecase,
       _fetchProjectsUsecase = fetchProjectsUsecase,
       super(NoticeListModel.initial());

  /// 앱 초기화 시 사용자 기준 프로젝트 + 공지 불러오기
  Future<void> initialize(UserEntity user) async {
    state = state.copyWith(isLoading: true, error: null);

    final projectResult = await _fetchProjectsUsecase.execute(user);

    if (projectResult is Ok<List<Project>>) {
      final projects = projectResult.value;
      state = state.copyWith(
        projects: projects,
        selectedProjects: List.from(projects),
      );
      final noticeResult = await _retrieveUsecase.execute(projects);

      state = switch (noticeResult) {
        Ok(value: final notices) => state.copyWith(
          notices: notices,
          selectedNotices: List.from(notices),
          isLoading: false,
        ),
        Error(:final error) => state.copyWith(
          isLoading: false,
          error: error.toString(),
        ),
      };
    } else if (projectResult is Error) {
      state = state.copyWith(
        isLoading: false,
        error: (projectResult as Error).error.toString(),
      );
    }
  }

  void addProject(Project project) {
    final updatedProjects = [...state.selectedProjects, project];
    state = state.copyWith(selectedProjects: updatedProjects);
    // _refreshNotices();
    filterNoticesBySelection();
  }

  void removeProject(Project project) {
    final updatedProjects =
        state.selectedProjects.where((p) => p.id != project.id).toList();
    state = state.copyWith(selectedProjects: updatedProjects);
    // _refreshNotices();
    filterNoticesBySelection();
  }

  Future<void> _refreshNotices() async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _retrieveUsecase.execute(state.selectedProjects);

    state = switch (result) {
      Ok(value: final notices) => state.copyWith(
        notices: notices,
        isLoading: false,
      ),
      Error(:final error) => state.copyWith(
        isLoading: false,
        error: error.toString(),
      ),
    };
  }

  Future<void> markAsRead({
    required Notice notice,
    required UserEntity user,
  }) async {
    final result = await _markAsReadUsecase.execute(notice: notice);

    if (result is Ok<Notice>) {
      final updated = result.value;
      final updatedList =
          state.notices.map((n) => n.id == updated.id ? updated : n).toList();
      state = state.copyWith(notices: updatedList);
    }
  }

  void filterNoticesBySelection() {
    final filtered =
        state.notices
            .where(
              (notice) =>
                  state.selectedProjects.any((p) => p.id == notice.projectId),
            )
            .toList();

    state = state.copyWith(selectedNotices: filtered);
  }
}
