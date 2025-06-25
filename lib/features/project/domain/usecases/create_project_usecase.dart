import 'dart:developer';

import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/features/todo/domain/entities/todo.dart';
import 'package:todomodu_app/features/project/domain/repositories/project_repository.dart';

class CreateProjectUsecase {
  final ProjectRepository repository;

  CreateProjectUsecase(this.repository);

  /// [project]는 생성할 프로젝트 정보
  /// [todos]는 프로젝트에 포함될 할 일들
  /// [subtasks]는 각 todo.title에 매핑된 서브태스크 제목 리스트
  Future<void> execute(Project project) {
    return repository.createProject(project);
  }
}
