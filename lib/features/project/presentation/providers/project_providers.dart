<<<<<<< HEAD
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/project/data/datasources/project_data_source_impl.dart';
import 'package:todomodu_app/features/project/data/repositories/project_repository_impl.dart';
import 'package:todomodu_app/features/project/domain/repositories/project_repository.dart';
import 'package:todomodu_app/features/project/domain/usecases/fetch_projects_by_user_usecase.dart';
import 'package:todomodu_app/features/todo/presentation/providers/todo_repository_provider.dart';
import 'package:todomodu_app/features/user/presentation/providers/user_providers.dart';

final _projectDataSource = Provider<ProjectDataSourceImpl>((ref) {
  return ProjectDataSourceImpl(firestore: FirebaseFirestore.instance);
});

final projectRepository = Provider<ProjectRepository>((ref) {
  return ProjectRepositoryImpl(
    dataSource: ref.watch(_projectDataSource),
    userRepository: ref.watch(userRepositoryProvider),
    todoRepository: ref.watch(todoRepositoryProvider),
  );
});

final fetchProjectsByUserUsecase = Provider<FetchProjectsByUserUsecase>((ref) {
  return FetchProjectsByUserUsecase(
    projectRepository: ref.watch(projectRepository),
  );
=======
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/project/data/datasources/project_data_source.dart';
import 'package:todomodu_app/features/project/data/datasources/project_data_source_impl.dart';
import 'package:todomodu_app/features/project/data/repositories/project_repository_impl.dart';
import 'package:todomodu_app/features/project/domain/repositories/project_repository.dart';
import 'package:todomodu_app/features/project/domain/usecases/get_projects_usecase.dart';

final _projectDataSourceProvider = Provider<ProjectDataSource>((ref) {
  return ProjectDataSourceImpl();
});

final _projectRepositoryProvider = Provider<ProjectRepository>((ref) {
  final dataSource = ref.read(_projectDataSourceProvider);
  return ProjectRepositoryImpl(dataSource);
});

final getProjectsUsecaseProvider = Provider((ref) {
  final projectRepo = ref.read(_projectRepositoryProvider);
  return GetProjectsUsecase(projectRepo);
>>>>>>> 61c9c2a (feat : change projectState and make usecases file)
});
