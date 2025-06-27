import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todomodu_app/features/todo/domain/entities/subtask.dart';
import 'package:todomodu_app/features/todo/data/models/subtask_dto.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/features/user/presentation/providers/user_providers.dart';
import 'package:todomodu_app/features/user/domain/usecases/get_user_by_user_id_usecase.dart';

final subtaskStreamProvider = StreamProvider.family<List<Subtask>, (String projectId, String todoId)>((ref, args) {
  final (projectId, todoId) = args;
  final firestore = FirebaseFirestore.instance;
  final getUserById = ref.read(getUserByUserIdUsecaseProvider);

  final snapshots = firestore
      .collection('projects')
      .doc(projectId)
      .collection('subtasks')
      .where('todoId', isEqualTo: todoId)
      .snapshots();
return snapshots.asyncMap((querySnap) async {
  try {
    final futures = querySnap.docs.map((doc) async {
      final dto = SubtaskDto.fromJson(doc.data(), id: doc.id);

      List<UserEntity>? assignee;
      if (dto.assigneeId != null && dto.assigneeId!.isNotEmpty) {
        final users = await Future.wait(
          dto.assigneeId!.map((id) async {
            try {
              final user = await getUserById.execute(id).first;
              return user;
            } catch (e) {
              debugPrint('fetchUser($id) 실패: $e');
              return null;
            }
          }).toList(),
        );
        assignee = users.whereType<UserEntity>().toList();
      }

      return dto.toEntity(assignee: assignee);
    }).toList();

    return await Future.wait(futures);
  } catch (e, st) {
    debugPrint('❗ getSubtasksByProjectId 에러: $e\n$st');
    return [];
  }
});
});