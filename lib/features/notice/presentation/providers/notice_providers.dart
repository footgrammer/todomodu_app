import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/activity_history/presentation/providers/activity_history_providers.dart';
import 'package:todomodu_app/features/notice/data/datasources/notice_data_source_impl.dart';
import 'package:todomodu_app/features/notice/data/repositories/notice_repository_impl.dart';
import 'package:todomodu_app/features/notice/domain/entities/notice.dart';
import 'package:todomodu_app/features/notice/domain/usecase/create_notice_usecase.dart';
import 'package:todomodu_app/features/notice/domain/usecase/mark_notice_as_read_usecase.dart';
import 'package:todomodu_app/features/notice/domain/usecase/retrieve_notices_by_projects_usecase.dart';
import 'package:todomodu_app/features/notice/domain/usecase/watch_notice_by_project_id_usecase.dart';
import 'package:todomodu_app/features/notice/domain/usecase/watch_notices_by_simple_projects_usecase.dart';
import 'package:todomodu_app/features/notice/presentation/models/notice_create_model.dart';
import 'package:todomodu_app/features/notice/presentation/models/notice_list_model.dart';
import 'package:todomodu_app/features/notice/presentation/viewmodels/notice_create_view_model.dart';
import 'package:todomodu_app/features/notice/presentation/viewmodels/notice_list_for_project_view_model.dart';
import 'package:todomodu_app/features/notice/presentation/viewmodels/notice_list_view_model.dart';
import 'package:todomodu_app/features/project/presentation/providers/project_providers.dart';
import 'package:todomodu_app/features/user/presentation/providers/user_providers.dart';

final _noticeDataSourceProvider = Provider<NoticeDataSourceImpl>((ref) {
  return NoticeDataSourceImpl(firestore: FirebaseFirestore.instance);
});

final noticeRepositoryProvider = Provider<NoticeRepositoryImpl>((ref) {
  return NoticeRepositoryImpl(
    dataSource: ref.watch(_noticeDataSourceProvider),
    userRepository: ref.watch(userRepositoryProvider),
    projectRepository: ref.watch(projectRepositoryProvider),
  );
});

final createNoticeUsecaseProvider = Provider<CreateNoticeUsecase>((ref) {
  return CreateNoticeUsecase(
    noticeRepository: ref.watch(noticeRepositoryProvider),
    logActivityHistoryUsecase: ref.watch(logActivityHistoryUsecaseProvider),
  );
});

final retrieveNoticesByProjectsUsecase =
    Provider<RetrieveNoticesByProjectsUsecase>((ref) {
      return RetrieveNoticesByProjectsUsecase(
        noticeRepository: ref.watch(noticeRepositoryProvider),
      );
    });

final markNoticeAsReadUsecaseProvider = Provider<MarkNoticeAsReadUsecase>((
  ref,
) {
  return MarkNoticeAsReadUsecase(
    noticeRepository: ref.watch(noticeRepositoryProvider),
    userRepository: ref.watch(userRepositoryProvider),
  );
});

final noticeCreateViewModelProvider = AsyncNotifierProvider.family<
  NoticeCreateViewModel,
  NoticeCreateModel,
  String
>(NoticeCreateViewModel.new);

final watchNoticesBySimpleProjectsUsecaseProvider =
    Provider<WatchNoticesBySimpleProjectsUsecase>((ref) {
      final noticeRepository = ref.read(noticeRepositoryProvider);
      return WatchNoticesBySimpleProjectsUsecase(repository: noticeRepository);
    });

// features/notice/presentation/providers/notice_providers.dart
final noticeListViewModelProvider =
    AsyncNotifierProvider.autoDispose<NoticeListViewModel, NoticeListModel>(
      NoticeListViewModel.new,
    );

final watchNoticesByProjectIdUsecaseProvider =
    Provider<WatchNoticesByProjectIdUsecase>((ref) {
      final repository = ref.read(noticeRepositoryProvider);
      return WatchNoticesByProjectIdUsecase(repository);
    });

final noticeListForProjectViewModelProvider = AsyncNotifierProvider.autoDispose
    .family<NoticeListForProjectViewModel, List<Notice>, String>(
      NoticeListForProjectViewModel.new,
    );
