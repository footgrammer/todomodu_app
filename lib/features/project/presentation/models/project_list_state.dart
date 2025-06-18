// 상태 클래스
import 'package:todomodu_app/features/project/data/models/project_dto.dart';
import 'package:todomodu_app/features/project/domain/entities/project.dart';

class ProjectListState {
  List<Project>? projects;

  ProjectListState(this.projects);
}
