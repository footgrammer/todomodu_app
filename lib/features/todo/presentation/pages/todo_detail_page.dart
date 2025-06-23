import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
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
      body: SafeArea(
        bottom: true,
        minimum: EdgeInsets.only(bottom: 34),
        child: Column(
        
          children: [
            Padding(
              padding: const EdgeInsets.only(
                right: 24,
                left: 24,
                top: 8,
              ),
              child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo.title,
                    style: AppTextStyles.header2.copyWith(
                      color: AppColors.grey800,
                    ),
                  ),
                  SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildInfo('시작일', formatDate(todo.startDate)),
                      _buildInfo('종료일', formatDate(todo.endDate)),
                      _buildInfo('만든 이', '김영우'), // 이름 좌측 프로필 아이콘 추가
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    '할 일 목록',
                    style: AppTextStyles.subtitle1.copyWith(
                      color: AppColors.grey800,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.grey75,
                ),
                child: asyncSubtasks.when(
                  data:
                      (subtasks) => ListView.separated(
                        itemCount: subtasks.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
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
                  loading: () => const Center(child: CircularProgressIndicator()),
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
          style: AppTextStyles.subtitle3.copyWith(color: AppColors.grey500),
        ),
        Text(
          value,
          style: AppTextStyles.body2.copyWith(color: AppColors.grey800),
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDone ? AppColors.grey200 : Colors.white,
        border: Border.all(color: AppColors.grey100),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onToggle,
            child: SvgPicture.asset(
              isDone
                  ? 'assets/images/check_box_true.svg'
                  : 'assets/images/check_box_false.svg',
              width: 24,
              height: 24,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.body2.copyWith(
                color: AppColors.grey800,
                decoration:
                    isDone ? TextDecoration.lineThrough : TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
