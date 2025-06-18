import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/repositories/subtask_repository_impl.dart';
import '../../domain/repositories/subtask_repository.dart';

final subtaskRepositoryProvider = Provider<SubtaskRepository>((ref) {
  return SubtaskRepositoryImpl(FirebaseFirestore.instance);
});
