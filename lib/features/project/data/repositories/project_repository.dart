// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:todomodu_app/features/project/domain/entities/project.dart';

// class ProjectRepository {
//   Future<List<Project>> getProjects() async {
//     final firestore = FirebaseFirestore.instance;
//     final collectionRef = firestore.collection('projects');
//     final result = await collectionRef.get();
//     // final docs = result.docs;
//     List<Project> projects = [];

//     return projects;
//   }
// }


import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/shared/types/result.dart';

/// 🛠 기존 인터페이스 유지 + 단일 프로젝트 조회 기능 추가
abstract class ProjectRepository {
  Future<Result<List<Project>>> fetchProjectsByUser(UserEntity user);

  // ✅ 새로 추가: projectId로 프로젝트 단건 조회
  Future<Result<Project>> fetchProjectById(String projectId);
}
