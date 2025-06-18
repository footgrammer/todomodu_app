import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/project/presentation/viewmodels/project_create_view_model.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project_create/project_todo_subtask_list.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';
import 'package:todomodu_app/shared/widgets/common_elevated_button.dart';

class ProjectCreateSubtaskPage extends ConsumerWidget {
  const ProjectCreateSubtaskPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(projectCreateViewModelProvider.notifier);
    final state = ref.watch(projectCreateViewModelProvider);

    // 최초 1회만 복사
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (viewModel.initialSubtasks.isEmpty) {
        viewModel.cacheInitialSubtasks(state.selectedSubtasks);
      }
    });

    final selectedTodos = state.selectedTodos;
    final todoToAllSubtasks = viewModel.initialSubtasks;

    return Scaffold(
      appBar: AppBar(
        title: Row(children: [Text('프로젝트 추가하기', style: AppTextStyles.header2)]),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('할 일을 더 자세히 나눠볼까요?', style: AppTextStyles.header2),
            const SizedBox(height: 8),
            Text(
              '선택한 일들을 조금 더 구체적으로 쪼개봤어요.\n아래 세부 항목 중 지금 꼭 필요한 것만 골라주세요.',
              style: AppTextStyles.subtitle3.copyWith(color: AppColors.grey500),
            ),
            const SizedBox(height: 80),
            ProjectTodoSubtaskList(
              selectedTodos: selectedTodos,
              projectCreateState: state,
              todoToAllSubtasks: todoToAllSubtasks,
              viewModel: viewModel,
              onTap: (String todo) {
                ref
                    .read(projectCreateViewModelProvider.notifier)
                    .toggleExpandedItems(todo);
              },
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 40, top: 10),
              child: CommonElevatedButton(
                text: '완료',
                buttonColor: AppColors.primary500,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
