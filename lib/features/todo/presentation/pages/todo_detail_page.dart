import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/todo/presentation/pages/edit_todo_page.dart';
import 'package:todomodu_app/features/todo/presentation/providers/delete_todo_usecase_provider.dart';
import 'package:todomodu_app/features/todo/presentation/providers/subtask/toggle_subtask_done_usecase_provider.dart';
import 'package:todomodu_app/features/todo/presentation/providers/subtask/subtask_stream_provider.dart';
import 'package:todomodu_app/features/todo/domain/entities/todo.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

class TodoDetailPage extends ConsumerWidget {
  final Todo todo;

  const TodoDetailPage({super.key, required this.todo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSubtasks = ref.watch(
      subtaskStreamProvider((todo.projectId, todo.id)),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
        centerTitle: false,
        actions: [
          PopupMenuButton<String>(
            menuPadding: const EdgeInsets.symmetric(horizontal: 16),
            icon: const Icon(Icons.more_vert),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            offset: const Offset(-10, 40),
            color: Colors.white,
            elevation: 6,
            onSelected: (value) async {
              if (value == 'edit') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditTodoPage(todo: todo),
                  ),
                );
              } else if (value == 'delete') {
                await ref
                    .read(deleteTodoUseCaseProvider)
                    .call(projectId: todo.projectId, todoId: todo.id);
                if (context.mounted) Navigator.pop(context);
              }
            },
            itemBuilder:
                (context) => [
                  PopupMenuItem(
                    value: 'edit',
                    padding: EdgeInsets.zero,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '할 일 수정하기',
                        style: AppTextStyles.body2.copyWith(
                          color: AppColors.grey800,
                        ),
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    padding: EdgeInsets.zero,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '할 일 삭제하기',
                        style: AppTextStyles.body2.copyWith(
                          color: AppColors.grey800,
                        ),
                      ),
                    ),
                  ),
                ],
          ),
          const SizedBox(width: 14),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfo('시작일', formatDate(todo.startDate)),
                _buildInfo('종료일', formatDate(todo.endDate)),
                _buildInfo('만든 이', '이름'),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              '할 일 목록',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: asyncSubtasks.when(
                  data:
                      (subtasks) => ListView.separated(
                        itemCount: subtasks.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final subtask = subtasks[index];

                          return _SubtaskItem(
                            title: subtask.title,
                            isDone: subtask.isDone,
                            onToggle: () {
                              ref
                                  .read(toggleSubtaskDoneUseCaseProvider)
                                  .call(
                                    subtaskId: subtask.id,
                                    todoId: subtask.todoId ?? todo.id,
                                    projectId: subtask.projectId,
                                    isDone: !subtask.isDone,
                                  );
                            },
                          );
                        },
                      ),
                  loading:
                      () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(child: Text('오류 발생: $e')),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfo(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  String formatDate(DateTime date) {
    return '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';
  }
}

class _SubtaskItem extends StatelessWidget {
  final String title;
  final bool isDone;
  final VoidCallback onToggle;

  const _SubtaskItem({
    required this.title,
    required this.isDone,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: isDone ? Colors.grey[200] : Colors.white,
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onToggle,
            child: Icon(
              isDone ? Icons.check_circle : Icons.radio_button_unchecked,
              color: isDone ? Colors.grey[700] : Colors.grey[400],
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                decoration:
                    isDone ? TextDecoration.lineThrough : TextDecoration.none,
                color: isDone ? Colors.black54 : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
