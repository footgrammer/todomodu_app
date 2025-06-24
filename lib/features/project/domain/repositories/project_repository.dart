import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/shared/types/result.dart';

import 'package:todomodu_app/features/todo/domain/entities/todo.dart';

abstract interface class ProjectRepository {
  Future<Result<List<Project>>> fetchProjectsByUser(UserEntity user);
  Future<void> createProject(
    Project project, // ✅ Entity
    List<Todo> todos, // ✅ Entity
    Map<String, List<String>> subtasks, // ✅ Entity 기반 정보
  );
}
