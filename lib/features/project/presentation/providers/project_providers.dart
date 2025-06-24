//project_detail_page에서 단일 프로젝트 정보가 필요해서 코드 수정이 불가피했습니다. gpt한테 수정한 부분 주석 달아달라고 했어요.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/project/data/datasources/project_data_source_impl.dart';
import 'package:todomodu_app/features/project/data/repositories/project_repository_impl.dart';
import 'package:todomodu_app/features/project/domain/repositories/project_repository.dart';
import 'package:todomodu_app/features/project/domain/usecases/fetch_projects_by_user_usecase.dart';
import 'package:todomodu_app/features/project/domain/usecases/fetch_project_by_id_usecase.dart'; // ✅ [1] 새로 추가한 usecase
import 'package:todomodu_app/features/project/presentation/models/project_list_state.dart';
import 'package:todomodu_app/features/project/presentation/viewmodels/project_list_view_model.dart';
import 'package:todomodu_app/features/todo/presentation/providers/todo_repository_provider.dart';
import 'package:todomodu_app/features/user/presentation/providers/user_providers.dart';

/// ✅ [2] 기존 프로젝트 데이터소스 등록
final _projectDataSource = Provider<ProjectDataSourceImpl>((ref) {
  return ProjectDataSourceImpl(firestore: FirebaseFirestore.instance);
});

/// ✅ [3] ProjectRepository 구현 등록
final projectRepositoryProvider = Provider<ProjectRepository>((ref) {
  return ProjectRepositoryImpl(
    dataSource: ref.watch(_projectDataSource),
    userRepository: ref.watch(userRepositoryProvider),
    todoRepository: ref.watch(todoRepositoryProvider),
  );
});

/// ✅ [4] 프로젝트 리스트용 UseCase
final fetchProjectsByUserUsecaseProvider = Provider<FetchProjectsByUserUsecase>(
  (ref) {
    return FetchProjectsByUserUsecase(
      projectRepository: ref.watch(projectRepositoryProvider),
    );
  },
);

/// ✅ [5] 프로젝트 단건 조회용 UseCase (추가)
final fetchProjectByIdUsecaseProvider = Provider<FetchProjectByIdUsecase>((ref) {
  return FetchProjectByIdUsecase(
    repository: ref.watch(projectRepositoryProvider),
  );
});

/// ✅ [6] 단건 프로젝트 FutureProvider (추가)
final projectProvider = FutureProvider.family.autoDispose((ref, String projectId) async {
  final usecase = ref.watch(fetchProjectByIdUsecaseProvider);
  final result = await usecase.execute(projectId);
  return result.when(
    ok: (project) => project,
    error: (e) => throw e,
  );
});

/// ✅ [7] 기존 프로젝트 리스트 ViewModel
final projectListViewModelProvider =
    NotifierProvider<ProjectListViewModel, ProjectListState>(() {
  return ProjectListViewModel();
});
