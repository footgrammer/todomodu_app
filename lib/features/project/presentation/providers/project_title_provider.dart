//할 일 페이지에서 할 일 목록 불러올 때, 프로젝트 이름도 같이 표시
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final projectTitleProvider = FutureProvider.family<String, String>((ref, projectId) async {
  final doc = await FirebaseFirestore.instance.collection('projects').doc(projectId).get();
  if (doc.exists) {
    return doc.data()?['title'] ?? '프로젝트 없음';
  } else {
    return '프로젝트 없음';
  }
});
