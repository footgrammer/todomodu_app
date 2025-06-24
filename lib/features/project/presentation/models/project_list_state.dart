// 상태 클래스
import 'package:todomodu_app/features/project/domain/entities/project.dart';

class ProjectListState {
  List<Project>? projects;

  ProjectListState({required this.projects});

  ProjectListState copyWith({List<Project>? projects}) {
    return ProjectListState(projects: projects ?? this.projects);
  }
}
