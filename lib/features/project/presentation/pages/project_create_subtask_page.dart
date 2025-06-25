import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/features/project/presentation/models/project_create_state.dart';
import 'package:todomodu_app/features/project/presentation/providers/project_providers.dart';
import 'package:todomodu_app/features/project/presentation/viewmodels/project_create_view_model.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project_create/project_todo_subtask_list.dart';
import 'package:todomodu_app/features/todo/domain/entities/subtask.dart';
import 'package:todomodu_app/features/todo/domain/entities/todo.dart';
import 'package:todomodu_app/features/user/presentation/pages/main/main_page.dart';
import 'package:todomodu_app/features/user/presentation/providers/user_providers.dart';
import 'package:todomodu_app/features/user/presentation/viewmodels/user_view_model.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';
import 'package:todomodu_app/shared/utils/navigate_to_page.dart';
import 'package:todomodu_app/shared/widgets/common_elevated_button.dart';

class ProjectCreateSubtaskPage extends ConsumerWidget {
  List<dynamic> responseTodos;
  DateTime projectStartDate;
  DateTime projectEndDate;
  ProjectCreateSubtaskPage({
    super.key,
    required this.responseTodos,
    required this.projectStartDate,
    required this.projectEndDate,
  });

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
              padding: EdgeInsets.only(bottom: 64, top: 10),
              child: CommonElevatedButton(
                text: '완료',
                buttonColor: AppColors.primary500,
                onPressed: () async {
                  _createProject(ref, context, state);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _createProject(
    WidgetRef ref,
    BuildContext context,
    ProjectCreateState state,
  ) async {
    final userEntity =
        await ref.read(userViewModelProvider.notifier).fetchUser();

    List<Color> colorList = [
      AppColors.colorList1,
      AppColors.colorList2,
      AppColors.colorList3,
      AppColors.colorList4,
      AppColors.colorList5,
      AppColors.colorList6,
      AppColors.colorList7,
      AppColors.colorList8,
      AppColors.colorList9,
      AppColors.colorList10,
      AppColors.colorList11,
      AppColors.colorList12,
      AppColors.colorList13,
      AppColors.colorList14,
      AppColors.colorList15,
      AppColors.colorList16,
    ];
    final random = Random();
    final color = colorList[random.nextInt(16)];
    final invitationCode = (random.nextInt(900000) + 100000).toString();
    List<Todo> finalTodos =
        state.selectedTodos.map((todoTitle) {
          final subtasks =
              state.selectedSubtasks[todoTitle]!.map((subtaskTitle) {
                return Subtask(
                  id: '',
                  title: subtaskTitle,
                  isDone: false,
                  todoId: '',
                  projectId: '',
                );
              }).toList();

          final responseTodo =
              responseTodos
                  .where((todo) => todo.todoTitle == todoTitle)
                  .toList()
                  .first;
          return Todo(
            id: '',
            projectId: '',
            title: todoTitle,
            subtasks: subtasks,
            startDate: DateTime.parse(responseTodo.todoStartDate),
            endDate: DateTime.parse(responseTodo.todoEndDate),
            isDone: false,
          );
        }).toList();
    if (userEntity == null) {
      throw Exception('프로젝트 생성에 필요한 필수 정보가 누락되었습니다.');
    }

    final project = Project(
      id: '',
      title: state.title,
      description: state.description,
      startDate: projectStartDate,
      endDate: projectEndDate,
      owner: userEntity!,
      members: [userEntity],
      todos: finalTodos,
      invitationCode: invitationCode,
      isDone: false,
      color: color,
    );
    // await ref
    //     .read(projectCreateViewModelProvider.notifier)
    //     .createProject(
    //       project,
    //       finalTodos,
    //       ref.read(createProjectUsecaseProvider),
    //     );

    // navigateToPage(context, MainPage());
  }
}
