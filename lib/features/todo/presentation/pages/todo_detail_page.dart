import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todomodu_app/features/project/presentation/providers/project_providers.dart';
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
    final projectAsync = ref.watch(projectProvider(todo.projectId));

    return projectAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('프로젝트 로딩 실패: $e'))),
      data: (project) {
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
                        builder: (_) => EditTodoPage(
                          todo: todo,
                          projectMembers: project.members, // ✔ corrected
                        ),
                      ),
                    );
                  } else if (value == 'delete') {
                    final shouldDelete = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => Dialog(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 32),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '할 일 삭제하기',
                                style: AppTextStyles.header4.copyWith(color: AppColors.grey800),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '할 일을 삭제하시겠습니까?',
                                style: AppTextStyles.body2.copyWith(color: AppColors.grey800),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 24),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextButton(
                                      onPressed: () => Navigator.of(ctx).pop(false),
                                      style: TextButton.styleFrom(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24)),
                                        ),
                                        backgroundColor: Colors.white,
                                        foregroundColor: AppColors.grey400,
                                        textStyle: AppTextStyles.header4,
                                        padding: const EdgeInsets.only(top: 17.5, bottom: 16.5),
                                      ),
                                      child: const Text('취소'),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: TextButton(
                                      onPressed: () => Navigator.of(ctx).pop(true),
                                      style: TextButton.styleFrom(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(24)),
                                        ),
                                        backgroundColor: AppColors.grey75,
                                        foregroundColor: AppColors.primary600,
                                        textStyle: AppTextStyles.header4,
                                        padding: const EdgeInsets.only(top: 17.5, bottom: 16.5),
                                      ),
                                      child: const Text('삭제'),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );

                    if (shouldDelete == true) {
                      await ref.read(deleteTodoUseCaseProvider).call(
                        projectId: todo.projectId,
                        todoId: todo.id,
                      );
                      if (context.mounted) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('할 일이 삭제되었습니다.'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    }
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'edit',
                    padding: EdgeInsets.zero,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '할 일 수정하기',
                        style: AppTextStyles.body2.copyWith(color: AppColors.grey800),
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
                        style: AppTextStyles.body2.copyWith(color: AppColors.grey800),
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
            minimum: const EdgeInsets.only(bottom: 34),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 24, left: 24, top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        todo.title,
                        style: AppTextStyles.header2.copyWith(color: AppColors.grey800),
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildInfo('시작일', formatDate(todo.startDate)),
                          _buildInfo('종료일', formatDate(todo.endDate)),
                          // _buildInfo('만든 이', '김영우'),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        '할 일 목록',
                        style: AppTextStyles.subtitle1.copyWith(color: AppColors.grey800),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    decoration: BoxDecoration(color: AppColors.grey75),
                    child: asyncSubtasks.when(
                      data: (subtasks) => ListView.separated(
                        itemCount: subtasks.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final subtask = subtasks[index];
                          return _SubtaskItem(
                            title: subtask.title,
                            isDone: subtask.isDone,
                            onToggle: () {
                              ref.read(toggleSubtaskDoneUseCaseProvider).call(
                                subtaskId: subtask.id,
                                todoId: subtask.todoId,
                                projectId: subtask.projectId,
                                isDone: !subtask.isDone,
                              );
                              ref.invalidate(projectProvider(subtask.projectId));
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
      },
    );
  }

  Widget _buildInfo(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.subtitle3.copyWith(color: AppColors.grey500)),
        Text(value, style: AppTextStyles.body2.copyWith(color: AppColors.grey800)),
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
              isDone ? 'assets/images/check_box_true.svg' : 'assets/images/check_box_false.svg',
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
                decoration: isDone ? TextDecoration.lineThrough : TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
