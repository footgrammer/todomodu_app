import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/project/data/models/Project.dart';

// 상태 클래스
class ProjectState {
  List<Project>? projects;

  ProjectState(this.projects);
}

// 상태 클래스 관리할 뷰모델
class ProjectViewModel extends Notifier<ProjectState> {
  @override
  ProjectState build() {
    return ProjectState(null);
  }

  // void getProjects() async {
  //   ProjectRepository projectRepository = ProjectRepository();
  //   List<Project> projects = await projectRepository.getProjects();
  //   state = ProjectState(projects);
  // }

  void updateState(List<Project> projects) {
    state = ProjectState(projects);
  }
}

final projectViewModelProvider =
    NotifierProvider<ProjectViewModel, ProjectState>(() {
      return ProjectViewModel();
    });
