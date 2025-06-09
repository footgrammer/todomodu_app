import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todomodu_app/features/project/data/models/Project.dart';

class ProjectRepository {
  // Project getProject() {
  //   String data = "";
  //   // 1.jsonDecode 함수 사용해서 Map으로 변환
  //   // Map<String, dynamic> map = jsonDecode(data);

  //   // 2. map => 객체로 변환
  //   return Project.fromJson(map);
  // }
  Future<List<Project>> getProjects() async {
    final firestore = FirebaseFirestore.instance;
    final collectionRef = firestore.collection('projects');
    final result = await collectionRef.get();
    final docs = result.docs;
    List<Project> projects = [];
    for (var doc in docs) {
      print(doc.data());
      final data = doc.data() as Map<String, dynamic>;
      final mapWithId = {'id': doc.id, ...data};
      projects.add(Project.fromJson(mapWithId));
    }

    return projects;
  }
}
