import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/features/user/presentation/viewmodels/assignee_search_viewmodel.dart';

final assigneeSearchProvider = StateNotifierProvider.family<
    AssigneeSearchViewModel, List<UserEntity>, List<UserEntity>>(
  (ref, members) => AssigneeSearchViewModel(members),
);
