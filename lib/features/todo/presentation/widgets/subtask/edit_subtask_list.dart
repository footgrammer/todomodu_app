import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/todo/domain/entities/todo.dart';
import 'package:todomodu_app/features/todo/presentation/providers/edit_todo_viewmodel_provider.dart';
import 'package:todomodu_app/features/todo/presentation/widgets/subtask/subtask_item.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/shared/constants/app_colors.dart';
import 'package:uuid/uuid.dart';
import '../../../domain/entities/subtask.dart';
import '../../providers/subtask/subtask_stream_provider.dart';
import 'package:todomodu_app/features/todo/presentation/viewmodels/subtask_viewmodel.dart';

class EditSubtaskList extends ConsumerWidget {
  final Todo todo;
  final List<UserEntity> projectMembers;

  const EditSubtaskList({
    super.key,
    required this.todo,
    required this.projectMembers,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(editTodoViewModelProvider(todo).notifier);
    final state = ref.watch(editTodoViewModelProvider(todo));
    final subtasks = state.subtasks;

    return Column(
      children: [
        ...subtasks.map(
          (subtask) => SubtaskItem(
            key: ValueKey(subtask.id),
            subtask: subtask,
            projectMembers: projectMembers,
            onChanged: viewModel.updateSubtask,
            onDelete: () => viewModel.removeSubtask(subtask.id),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: IconButton(
            icon: const Icon(
              Icons.add_circle,
              size: 48,
              color: AppColors.primary200,
            ),
            onPressed: () {
              final subtask = Subtask(
                id: const Uuid().v4(),
                title: '',
                isDone: false,
                todoId: todo.id,
                projectId: todo.projectId,
              );
              viewModel.addSubtask(subtask);
            },
          ),
        ),
      ],
    );
  }
}
