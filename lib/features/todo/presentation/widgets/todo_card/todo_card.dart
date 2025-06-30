import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todomodu_app/features/project/presentation/providers/project_providers.dart';
import 'package:todomodu_app/features/todo/presentation/widgets/todo_card/project_title_chip.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';
import '../../../domain/entities/todo.dart';
import '../../../domain/entities/subtask.dart';
import '../../providers/subtask/subtask_stream_provider.dart';
import '../../providers/subtask/toggle_subtask_done_usecase_provider.dart';
import '../../pages/todo_detail_page.dart';

class TodoCard extends ConsumerWidget {
  final Todo todo;
  final bool showProjectTitle;
  final bool showDateRange;
  final TextStyle? todoTitleTextStyle;

  const TodoCard({
    super.key,
    required this.todo,
    this.showProjectTitle = true,
    this.showDateRange = false,
    this.todoTitleTextStyle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSubs = ref.watch(
      subtaskStreamProvider((todo.projectId, todo.id)),
    );
    final toggleUsecase = ref.read(toggleSubtaskDoneUseCaseProvider);

    final dateRange =
        '${todo.startDate.year}.${todo.startDate.month.toString().padLeft(2, '0')}.${todo.startDate.day.toString().padLeft(2, '0')}'
        ' - '
        '${todo.endDate.year}.${todo.endDate.month.toString().padLeft(2, '0')}.${todo.endDate.day.toString().padLeft(2, '0')}';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => TodoDetailPage(todo: todo)),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.primary200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showProjectTitle) ProjectTitleChip(projectId: todo.projectId),
            Text(
              todo.title,
              style:
                  todoTitleTextStyle ??
                  AppTextStyles.body3.copyWith(color: AppColors.grey700),
            ),
            if (showDateRange) ...[
              Text(
                dateRange,
                style: AppTextStyles.body3.copyWith(color: AppColors.grey500),
              ),
            ],
            const SizedBox(height: 8),
            asyncSubs.when(
              data:
                  (subs) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        subs.map((s) {
                          return InkWell(
                            onTap: () async {
                              await toggleUsecase(
                                subtaskId: s.id,
                                todoId: s.todoId,
                                projectId: s.projectId,
                                isDone: !s.isDone,
                              );

                              ref.invalidate(projectProvider(s.projectId));
                            },
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  s.isDone
                                      ? 'assets/images/check_box_true.svg'
                                      : 'assets/images/check_box_false.svg',
                                  width: 24,
                                  height: 24,
                                ),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: Text(
                                    s.title,
                                    style: AppTextStyles.body2.copyWith(
                                      color: AppColors.grey900,
                                      decoration:
                                          s.isDone
                                              ? TextDecoration.lineThrough
                                              : null,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                  ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text('subtasks 에러: $e'),
            ),
          ],
        ),
      ),
    );
  }
}
