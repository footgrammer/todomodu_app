import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/ai/domain/models/openai_response.dart';
import 'package:todomodu_app/features/project/presentation/pages/project_create_page.dart';
import 'package:todomodu_app/features/project/presentation/pages/project_create_subtask_page.dart';
import 'package:todomodu_app/features/project/presentation/providers/project_providers.dart';
import 'package:todomodu_app/features/project/presentation/viewmodels/project_create_view_model.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project_create/project_todo_list.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';
import 'package:todomodu_app/shared/utils/navigate_to_page.dart';
import 'package:todomodu_app/shared/widgets/common_elevated_button.dart';

class ProjectCreateTodoPage extends ConsumerWidget {
  final OpenaiResponse response;

  const ProjectCreateTodoPage({super.key, required this.response});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = response.todos;
    final selectedTodos = ref.watch(
      projectCreateViewModelProvider.select((state) => state.selectedTodos),
    );
    final viewModel = ref.read(projectCreateViewModelProvider.notifier);
    // ✅ 상태 변경은 build 이후에 수행
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (selectedTodos.isEmpty) {
        viewModel.selectAllTodos(todos);
      }
    });

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            navigateToPage(context, ProjectCreatePage());
          },
          child: Icon(Icons.arrow_back_ios),
        ),
        title: Row(children: [Text('프로젝트 추가하기', style: AppTextStyles.header2)]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '이 프로젝트엔\n어떤 일이 필요할까요?',
              style: AppTextStyles.header2.copyWith(color: AppColors.grey800),
            ),
            const SizedBox(height: 8),
            Text(
              '프로젝트 내용을 바탕으로 할 일을 추천해봤어요.\n꼭 필요한 것만 골라주세요!',
              style: AppTextStyles.subtitle3.copyWith(color: AppColors.grey500),
            ),
            const SizedBox(height: 48),
            Expanded(
              child: ListView(
                children: [
                  ProjectTodoList(
                    todos: todos,
                    selectedTodos: selectedTodos,
                    viewModel: viewModel,
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 64, top: 10),
              child: CommonElevatedButton(
                text: '다음',
                buttonColor: AppColors.primary500,
                onPressed: () {
                  goToProjectCreateSubtaskPage(context, viewModel, todos);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void goToProjectCreateSubtaskPage(
    BuildContext context,
    ProjectCreateViewModel viewModel,
    List<dynamic> todos,
  ) {
    //빌드 후에 상태를 변경할 수 있도록 함
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.selectAllSubtasks(todos); // 상태 변경
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProjectCreateSubtaskPage()),
      );
    });
  }
}
