import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todomodu_app/features/project/domain/entities/project.dart';

class ProjectRepository {
  Future<List<Project>> getProjects() async {
    final firestore = FirebaseFirestore.instance;
    final collectionRef = firestore.collection('projects');
    final result = await collectionRef.get();
    // final docs = result.docs;
    List<Project> projects = [];

    return projects;
  }
}
