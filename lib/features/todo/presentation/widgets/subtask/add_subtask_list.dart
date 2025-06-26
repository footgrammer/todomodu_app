import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/todo/presentation/widgets/subtask/subtask_item.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';
import 'package:uuid/uuid.dart';
import 'package:todomodu_app/features/todo/presentation/providers/add_todo_viewmodel_provider.dart';
import '../../../domain/entities/subtask.dart';

class AddSubtaskList extends ConsumerWidget {
  final String projectId;
  final String todoId;
  final List<UserEntity> projectMembers;

  const AddSubtaskList({
    super.key,
    required this.projectId,
    required this.todoId,
    required this.projectMembers,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(addTodoViewModelProvider(projectId).notifier);
    final state = ref.watch(addTodoViewModelProvider(projectId));

    return Column(
      children: [
        ...state.subtasks.map(
          (subtask) => SubtaskItem(
            key: ValueKey(subtask.id),
            subtask: subtask,
            projectMembers: projectMembers,
            onChanged: viewModel.updateSubtask,
            onDelete: () => viewModel.removeSubtask(subtask.id),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: IconButton(
            icon: const Icon(Icons.add_circle, size: 48, color: AppColors.primary200),
            onPressed: () {
              final subtask = Subtask(
                id: const Uuid().v4(),
                title: '',
                isDone: false,
                todoId: todoId,
                projectId: projectId,
              );
              viewModel.addSubtask(subtask);
            },
          ),
        ),
      ],
    );
  }
}
