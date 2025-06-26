import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todomodu_app/features/todo/data/datasources/subtask_datasource.dart';
import 'package:todomodu_app/features/todo/data/datasources/subtask_datasource_impl.dart';

final subtaskDatasourceProvider = Provider<SubtaskDatasource>((ref) {
  return SubtaskDatasourceImpl(firestore: FirebaseFirestore.instance);
});
