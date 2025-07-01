import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/notice/domain/entities/notice.dart';
import 'package:todomodu_app/features/notice/domain/extensions/notice_extension.dart';
import 'package:todomodu_app/features/notice/domain/usecase/retrieve_notices_by_projects_usecase.dart';
import 'package:todomodu_app/features/notice/domain/usecase/mark_notice_as_read_usecase.dart';
import 'package:todomodu_app/features/notice/presentation/models/notice_list_model.dart';
import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/features/project/domain/usecases/fetch_projects_by_user_usecase.dart';
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
  /// 내부에서 실제 초기화를 처리하는 공통 함수
  Future<void> _initializeInternal(UserEntity user) async {
    state = state.copyWith(isLoading: true, error: null);

    final projectResult = await _fetchProjectsUsecase.execute(user);

    if (projectResult case Ok<List<Project>>(:final value)) {
      final projects = value;

      final noticeResult = await _retrieveUsecase.execute(projects);

      state = switch (noticeResult) {
        Ok(value: final notices) => state.copyWith(
          currentUser: user,
          projects: projects,
          selectedProjects: List.from(projects),
          notices: notices,
          selectedNotices: List.from(notices),
          isLoading: false,
        ),
        Error(:final error) => state.copyWith(
          isLoading: false,
          error: error.toString(),
        ),
      };
    } else if (projectResult case Error(:final error)) {
      state = state.copyWith(isLoading: false, error: error.toString());
    }
  }

  /// 외부에서 유저를 전달받는 초기화
  Future<void> initialize(UserEntity user) async {
    await _initializeInternal(user);
  }

  /// 내부에 저장된 유저 정보를 바탕으로 초기화
  Future<void> initializeWithoutUserParam() async {
    final currentUser = state.currentUser;
    if (currentUser == null) {
      state = state.copyWith(error: '사용자 정보가 없습니다.');
      return;
    }
    await _initializeInternal(currentUser);
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
    // required UserEntity user,
  }) async {
    final result = await _markAsReadUsecase.execute(
      notice: notice,
      user: state.currentUser!,
    );

    if (result is Ok<Notice>) {
      final updated = result.value;

      final updatedNotices =
          state.notices.map((n) => n.id == updated.id ? updated : n).toList();

      final updatedSelected =
          state.selectedNotices
              .map((n) => n.id == updated.id ? updated : n)
              .toList();

      state = state.copyWith(
        notices: updatedNotices,
        selectedNotices: updatedSelected, // ✅ 이것도 함께 갱신
      );
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

  Color getColorByNotice(Notice notice) {
    return state.projects.firstWhere((p) => p.id == notice.projectId).color;
  }

  void onClickAllChip() {
    if (state.selectedProjects.length != state.projects.length) {
      state = state.copyWith(selectedProjects: List.from(state.projects));
    } else {
      state = state.copyWith(selectedNotices: []);
    }
    filterNoticesBySelection();
  }

  bool isAllProjectsSelected() {
    return state.selectedProjects.length != state.projects.length;
  }

  bool hasUnreadNotices(Project project) {
    final unreadedNotices = state.notices.where(
      (n) => n.isUnread(state.currentUser!.userId),
    );
    final unreadedProjects = unreadedNotices.map((e) => e.projectId);
    return unreadedProjects.contains(project.id);
  }

  bool hasUnreadNoticesforDetail(String projectId) {
    final unreadedNotices = state.notices.where(
      (n) => n.isUnread(state.currentUser!.userId),
    );
    final unreadedProjects = unreadedNotices.map((e) => e.projectId);
    return unreadedProjects.contains(projectId);
  }

  List<Notice> getNoticesByProject(String projectId) {
    return state.notices.where((n) => n.projectId == projectId).toList();
  }

  Notice? getNoticeById(String id) {
    return state.notices.firstWhereOrNull((n) => n.id == id);
  }

  bool isUnread(Notice notice) {
    final latest = getNoticeById(notice.id);
    return latest?.isUnread(state.currentUser!.userId) ?? false;
  }

  void addNotice(Notice notice) {
    final updatedNotices = [notice, ...state.notices];
    final updatedSelected =
        state.selectedProjects.any((p) => p.id == notice.projectId)
            ? [notice, ...state.selectedNotices]
            : state.selectedNotices;

    state = state.copyWith(
      notices: updatedNotices,
      selectedNotices: updatedSelected,
    );
  }

  void addCreatedNotice(Notice notice) {
    final updatedNotices = [notice, ...state.notices];

    final shouldIncludeInSelected = state.selectedProjects.any(
      (p) => p.id == notice.projectId,
    );

    final updatedSelectedNotices =
        shouldIncludeInSelected
            ? [notice, ...state.selectedNotices]
            : state.selectedNotices;

    state = state.copyWith(
      notices: updatedNotices,
      selectedNotices: updatedSelectedNotices,
    );
  }

  void updateUser(UserEntity currentUser) {
    state = state.copyWith(currentUser: currentUser);
  }
}
