import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/features/project/presentation/models/project_list_state.dart';
import 'package:todomodu_app/features/project/presentation/providers/project_providers.dart';

class ProjectListViewModel extends Notifier<ProjectListState> {
  @override
  ProjectListState build() {
    return ProjectListState(null);
  }

  Future<void> getProjects() async {
    final getProjectUsecase = ref.read(getProjectsUsecaseProvider);
    final projects = await getProjectUsecase.execute();
    state = ProjectListState(projects);
  }
}

final projectListViewModelProvider =
    NotifierProvider<ProjectListViewModel, ProjectListState>(() {
      return ProjectListViewModel();
    });
