import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/project/data/datasources/project_data_source_impl.dart';
import 'package:todomodu_app/features/project/data/repositories/project_repository_impl.dart';
import 'package:todomodu_app/features/project/domain/repositories/project_repository.dart';
import 'package:todomodu_app/features/project/domain/usecases/create_project_usecase.dart';
import 'package:todomodu_app/features/project/domain/usecases/fetch_projects_by_user_id_usecase.dart';
import 'package:todomodu_app/features/project/domain/usecases/fetch_projects_by_user_usecase.dart';
import 'package:todomodu_app/features/project/presentation/models/project_create_state.dart';
import 'package:todomodu_app/features/project/presentation/models/project_list_state.dart';
import 'package:todomodu_app/features/project/presentation/viewmodels/project_create_view_model.dart';
import 'package:todomodu_app/features/project/presentation/viewmodels/project_list_view_model.dart';
import 'package:todomodu_app/features/todo/presentation/providers/todo_repository_provider.dart';
import 'package:todomodu_app/features/user/presentation/providers/user_providers.dart';

final _projectDataSource = Provider<ProjectDataSourceImpl>((ref) {
  return ProjectDataSourceImpl(firestore: FirebaseFirestore.instance);
});

final projectRepositoryProvider = Provider<ProjectRepository>((ref) {
  return ProjectRepositoryImpl(
    dataSource: ref.read(_projectDataSource),
    userRepository: ref.read(userRepositoryProvider),
    todoRepository: ref.read(todoRepositoryProvider),
  );
});

final fetchProjectsByUserUsecaseProvider = Provider<FetchProjectsByUserUsecase>(
  (ref) {
    return FetchProjectsByUserUsecase(
      projectRepository: ref.read(projectRepositoryProvider),
    );
  },
);

final projectListViewModelProvider =
    NotifierProvider<ProjectListViewModel, ProjectListState>(() {
      return ProjectListViewModel();
    });

final projectCreateViewModelProvider =
    NotifierProvider<ProjectCreateViewModel, ProjectCreateState>(() {
      return ProjectCreateViewModel();
    });

final createProjectUsecaseProvider = Provider<CreateProjectUsecase>((ref) {
  return CreateProjectUsecase(ref.watch(projectRepositoryProvider));
});

final fetchProjectsByUserIdUsecaseProvider =
    Provider<FetchProjectsByUserIdUsecase>((ref) {
      return FetchProjectsByUserIdUsecase(
        projectRepository: ref.read(projectRepositoryProvider),
      );
    });

// 프로젝트 가져올 때 1번만 가져올 수 있도록 함
final hasFetchedProvider = StateProvider<bool>((ref) => false);
