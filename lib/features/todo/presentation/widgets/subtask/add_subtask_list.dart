import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';
import 'package:uuid/uuid.dart';
import '../../../domain/entities/subtask.dart';
import '../../providers/subtask/subtask_stream_provider.dart';
import '../../viewmodels/subtask_viewmodel.dart';

class SubtaskList extends ConsumerWidget {
  final String projectId;
  final String todoId;

  const SubtaskList({super.key, required this.projectId, required this.todoId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSubtasks = ref.watch(subtaskStreamProvider((projectId, todoId)));
    final subtaskViewModel = ref.read(subtaskViewModelProvider);

    return Column(
      children: [
        asyncSubtasks.when(
          data: (subtasks) {
            return Column(
              children:
                  subtasks.map((subtask) {
                    final controller = TextEditingController(
                      text: subtask.title,
                    );

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                    right: 60,
                                    bottom: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.grey50,
                                    border: Border.all(
                                      color: AppColors.grey200,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: TextField(
                                    controller: controller,
                                    maxLength: 50,
                                    style: AppTextStyles.body2.copyWith(
                                      color: AppColors.grey800,
                                    ),
                                    onChanged: (value) {
                                      subtaskViewModel.update(
                                        subtask.copyWith(title: value),
                                      );
                                    },
                                    decoration: InputDecoration(
                                      hintText: '세부 할 일을 입력하세요',
                                      hintStyle: AppTextStyles.body2.copyWith(
                                        color: AppColors.grey400,
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 16,
                                      ),
                                      counterText: '',
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 16,
                                  bottom: 8,
                                  child: Text(
                                    '${controller.text.length}/50',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.grey400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          IconButton(
                            onPressed: () {
                              subtaskViewModel.delete(
                                projectId: projectId,
                                subtaskId: subtask.id,
                              );
                            },
                            icon: const Icon(Icons.remove),
                          ),
                        ],
                      ),
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
            icon: const Icon(Icons.add_circle, size: 48, color: AppColors.primary200,),
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
