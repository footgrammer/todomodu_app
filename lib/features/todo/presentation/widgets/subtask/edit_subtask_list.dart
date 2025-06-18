import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/subtask.dart';
import '../../providers/subtask_stream_provider.dart';
import 'package:todomodu_app/features/todo/presentation/viewmodels/subtask_viewmodel.dart';


class EditTodoSubtaskList extends ConsumerWidget {
  final String projectId;
  final String todoId;

  const EditTodoSubtaskList({
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
            final controller = TextEditingController(text: subtask.title);

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 60, bottom: 20),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: controller,
                            maxLength: 50,
                            onChanged: (value) {
                              final updated = subtask.copyWith(title: value);
                              viewModel.update(updated);
                            },
                            decoration: const InputDecoration(
                              hintText: '세부 할 일',
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                              counterText: '',
                            ),
                          ),
                        ),
                        Positioned(
                          right: 16,
                          bottom: 8,
                          child: Text(
                            '${controller.text.length}/50',
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () {
                      viewModel.delete(
                        projectId: projectId,
                        subtaskId: subtask.id,
                      );
                    },
                    icon: const Icon(Icons.remove_circle_outline),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (e, _) => Text('오류: $e'),
    );
  }
}
