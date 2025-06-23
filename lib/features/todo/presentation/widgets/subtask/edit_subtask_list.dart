import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/todo/presentation/widgets/subtask/subtask_item.dart';
import '../../../domain/entities/subtask.dart';
import '../../providers/subtask/subtask_stream_provider.dart';
import 'package:todomodu_app/features/todo/presentation/viewmodels/subtask_viewmodel.dart';


class EditSubtaskList extends ConsumerWidget {
  final String projectId;
  final String todoId;

  const EditSubtaskList({
    super.key,
    required this.projectId,
    required this.todoId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSubtasks = ref.watch(subtaskStreamProvider((projectId, todoId)));
    final viewModel = ref.watch(subtaskViewModelProvider);

    return asyncSubtasks.when(
      data: (subtasks) {
        return Column(
          children: subtasks.map((subtask) {
            return SubtaskItem(
              key: ValueKey(subtask.id),
              subtask: subtask,
              onChanged: (updated) {
                viewModel.update(updated);
              },
              onDelete: () {
                viewModel.delete(
                  projectId: projectId,
                  subtaskId: subtask.id,
                );
              },
            );
          }).toList(),
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (e, _) => Text('오류: $e'),
    );
  }
}