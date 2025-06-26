import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/features/todo/domain/entities/todo.dart';
import 'package:todomodu_app/features/todo/presentation/providers/subtask/subtask_stream_provider.dart';
import 'package:todomodu_app/features/todo/presentation/providers/todo_stream_provider.dart';
import 'package:todomodu_app/features/todo/presentation/widgets/todo_card/todo_card.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TodoListSection extends ConsumerWidget {
  final List<Project> projects;
  final DateTime selectedDate;
  final String uid;

  const TodoListSection({
    super.key,
    required this.projects,
    required this.selectedDate,
    required this.uid,
  });

  bool _isInRange(Todo todo, DateTime date) {
    return (todo.startDate.isBefore(date) || todo.startDate.isAtSameMomentAs(date)) &&
        (todo.endDate.isAfter(date) || todo.endDate.isAtSameMomentAs(date));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<Todo>>(
      future: () async {
        final todos = <Todo>[];

        for (final project in projects) {
          final projectTodos = await ref.read(todoStreamProvider(project.id).future);

          for (final todo in projectTodos) {
            if (!_isInRange(todo, selectedDate)) continue;

            final subtasks = await ref
                .read(subtaskStreamProvider((project.id, todo.id)).future);

            final hasMe = subtasks.any((s) => s.assignee?.userId == uid);
            if (hasMe) todos.add(todo);
          }
        }

        return todos;
      }(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final todosToShow = snapshot.data!;
        if (todosToShow.isEmpty) return _emptyState();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '할 일 ${todosToShow.length}개',
              style: AppTextStyles.body2.copyWith(color: AppColors.grey500),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: todosToShow.length,
                itemBuilder: (context, i) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TodoCard(
                    todo: todosToShow[i],
                    showProjectTitle: true,
                    showDateRange: false,
                    todoTitleTextStyle: AppTextStyles.body3.copyWith(
                      color: AppColors.grey700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/images/todo_empty_img.svg', height: 88, width: 62),
          const SizedBox(height: 15),
          Text('아직 등록된 할 일이 없습니다.',
              style: AppTextStyles.body2.copyWith(color: AppColors.grey800)),
          const SizedBox(height: 4),
          Text(
            '프로젝트에 참여하거나\n할 일을 할당받아 보세요!',
            textAlign: TextAlign.center,
            style: AppTextStyles.body2.copyWith(color: AppColors.grey500),
          ),
        ],
      ),
    );
  }
}
