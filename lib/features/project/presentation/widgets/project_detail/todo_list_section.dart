import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todomodu_app/features/todo/domain/entities/todo.dart';
import 'package:todomodu_app/features/todo/presentation/providers/todo_list_viewmodel_provider.dart';
import 'package:todomodu_app/features/todo/presentation/widgets/todo_card/todo_card.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

class TodoListSection extends ConsumerWidget {
  final String projectId;

  const TodoListSection({super.key, required this.projectId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(todoListViewModelProvider);
    final todosStream = viewModel.todosStream(projectId);

    return Container(
      decoration: BoxDecoration(color: AppColors.grey75),
      child: StreamBuilder<List<Todo>>(
        stream: todosStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('에러 발생: ${snapshot.error}'));
          }
          final todos = snapshot.data ?? [];
          if (todos.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/project_detail_todo_empty.svg',
                    width: 101,
                    height: 71,
                  ),
                  SizedBox(height: 15),
                  Text(
                    '아직 등록된 할 일이 없습니다.',
                    style: AppTextStyles.body2.copyWith(
                      color: AppColors.grey800,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '할 일을 추가하여\n프로젝트를 완성해보세요!',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.caption1.copyWith(
                      color: AppColors.grey500,
                    ),
                  ),
                ],
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.only(
              top: 16,
              right: 24,
              left: 24,
              bottom: 34,
            ),
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return TodoCard(
                todo: todo,
                showProjectTitle: false,
                showDateRange: true,
                todoTitleTextStyle: AppTextStyles.body1.copyWith(
                  color: AppColors.grey800,
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 8),
          );
        },
      ),
    );
  }
}
