import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/notice/data/datasources/notice_data_source_impl.dart';
import 'package:todomodu_app/features/notice/data/repositories/notice_repository_impl.dart';
import 'package:todomodu_app/features/notice/domain/usecase/create_notice_usecase.dart';
import 'package:todomodu_app/features/notice/domain/usecase/mark_notice_as_read_usecase.dart';
import 'package:todomodu_app/features/notice/domain/usecase/retrieve_notices_by_projects_usecase.dart';
import 'package:todomodu_app/features/notice/presentation/models/notice_create_model.dart';
import 'package:todomodu_app/features/notice/presentation/models/notice_list_model.dart';
import 'package:todomodu_app/features/notice/presentation/viewmodels/notice_create_view_model.dart';
import 'package:todomodu_app/features/notice/presentation/viewmodels/notice_list_view_model.dart';
import 'package:todomodu_app/features/project/presentation/providers/project_providers.dart';
import 'package:todomodu_app/features/user/presentation/providers/user_providers.dart';

final _noticeDataSourceProvider = Provider<NoticeDataSourceImpl>((ref) {
  return NoticeDataSourceImpl(firestore: FirebaseFirestore.instance);
});

final noticeRepositoryProvider = Provider<NoticeRepositoryImpl>((ref) {
  return NoticeRepositoryImpl(datasource: ref.watch(_noticeDataSourceProvider));
});

final createNoticeUsecaseProvider = Provider<CreateNoticeUsecase>((ref) {
  return CreateNoticeUsecase(
    noticeRepository: ref.watch(noticeRepositoryProvider),
  );
});

final retrieveNoticesByProjectsUsecase =
    Provider<RetrieveNoticesByProjectsUsecase>((ref) {
      return RetrieveNoticesByProjectsUsecase(
        noticeRepository: ref.watch(noticeRepositoryProvider),
      );
    });

final markNoticeAsReadUsecase = Provider<MarkNoticeAsReadUsecase>((ref) {
  return MarkNoticeAsReadUsecase(
    noticeRepository: ref.watch(noticeRepositoryProvider),
    userRepository: ref.watch(userRepositoryProvider),
  );
});

final noticeCreateViewModelProvider = StateNotifierProvider.family<
  NoticeCreateViewModel,
  NoticeCreateModel,
  String
>((ref, projectId) {
  return NoticeCreateViewModel(
    createNoticeUsecase: ref.watch(createNoticeUsecaseProvider),
    projectId: projectId,
  );
});

final noticeListViewModelProvider =
    StateNotifierProvider<NoticeListViewModel, NoticeListModel>((ref) {
      return NoticeListViewModel(
        retrieveUsecase: ref.watch(retrieveNoticesByProjectsUsecase),
        markAsReadUsecase: ref.watch(markNoticeAsReadUsecase),
        fetchProjectsUsecase: ref.watch(fetchProjectsByUserUsecaseProvider),
      );
    });
