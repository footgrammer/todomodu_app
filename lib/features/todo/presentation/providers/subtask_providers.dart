
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/todo/data/datasources/subtask_datasource_impl.dart';
import 'package:todomodu_app/features/todo/data/repositories/subtask_repository_impl.dart';

final _subtaskDataSourceProvider = Provider<SubtaskDatasourceImpl>((ref) {
  return SubtaskDatasourceImpl(firestore: FirebaseFirestore.instance);
});

final subtaskRepositoryProvider = Provider<SubtaskRepositoryImpl>((ref) {
  return SubtaskRepositoryImpl(dataSource: ref.watch(_subtaskDataSourceProvider));
});
