import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/notice/data/datasources/notice_data_source_impl.dart';
import 'package:todomodu_app/features/notice/data/repositories/notice_repository_impl.dart';
import 'package:todomodu_app/features/notice/domain/usecase/create_notice_usecase.dart';
import 'package:todomodu_app/features/notice/presentation/models/notice_create_model.dart';
import 'package:todomodu_app/features/notice/presentation/viewmodels/notice_create_view_model.dart';

final _noticeDataSourceProvider = Provider<NoticeDataSourceImpl>((ref) {
  return NoticeDataSourceImpl(firestore: FirebaseFirestore.instance);
});

final _noticeRepositoryProvider = Provider<NoticeRepositoryImpl>((ref) {
  return NoticeRepositoryImpl(datasource: ref.watch(_noticeDataSourceProvider));
});

final createNoticeUsecaseProvider = Provider<CreateNoticeUsecase>((ref) {
  return CreateNoticeUsecase(
    noticeRepository: ref.watch(_noticeRepositoryProvider),
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
