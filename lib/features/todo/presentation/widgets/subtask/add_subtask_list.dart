import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/todo/presentation/widgets/subtask/subtask_item.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';
import 'package:uuid/uuid.dart';
import '../../../domain/entities/subtask.dart';
import '../../providers/subtask/subtask_stream_provider.dart';
import '../../viewmodels/subtask_viewmodel.dart';

class AddSubtaskList extends ConsumerWidget {
  final String projectId;
  final String todoId;

  const AddSubtaskList({super.key, required this.projectId, required this.todoId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSubtasks = ref.watch(subtaskStreamProvider((projectId, todoId)));
    final subtaskViewModel = ref.read(subtaskViewModelProvider);

    return Column(
      children: [
        asyncSubtasks.when(
          data: (subtasks) {
            return Column(
              children: subtasks.map((subtask) {
                return SubtaskItem(
                  key: ValueKey(subtask.id),
                  subtask: subtask,
                  onChanged: (updated) {
                    subtaskViewModel.update(updated);
                  },
                  onDelete: () {
                    subtaskViewModel.delete(
                      projectId: projectId,
                      subtaskId: subtask.id,
                    );
                  },
                );
              }).toList(),
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (e, _) => Text('에러: $e'),
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
              subtaskViewModel.create(subtask);
            },
          ),
        ),
      ],
    );
  }
}