import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/datasources/todo_remote_datasource.dart';

final todoRemoteDataSourceProvider = Provider<TodoRemoteDataSource>((ref) {
  final firestore = FirebaseFirestore.instance;
  return TodoRemoteDataSource(firestore);
});
