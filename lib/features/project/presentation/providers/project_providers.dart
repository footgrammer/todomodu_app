import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/project/data/datasources/project_data_source_impl.dart';
import 'package:todomodu_app/features/project/data/repositories/project_repository_impl.dart';
import 'package:todomodu_app/features/project/domain/repositories/project_repository.dart';
import 'package:todomodu_app/features/project/domain/usecases/fetch_projects_by_user_usecase.dart';
import 'package:todomodu_app/features/user/presentation/providers/user_providers.dart';

final _projectDataSource = Provider<ProjectDataSourceImpl>((ref) {
  return ProjectDataSourceImpl(firestore: FirebaseFirestore.instance);
});

final projectRepository = Provider<ProjectRepository>((ref) {
  return ProjectRepositoryImpl(
    dataSource: ref.watch(_projectDataSource),
    userRepository: ref.watch(userRepositoryProvider),
  );
});

final fetchProjectsByUserUsecase = Provider<FetchProjectsByUserUsecase>((ref) {
  return FetchProjectsByUserUsecase(
    projectRepository: ref.watch(projectRepository),
  );
});
