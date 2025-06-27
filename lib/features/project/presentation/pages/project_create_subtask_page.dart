import 'dart:developer';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/ai/domain/models/openai_response.dart'
    as openai;
import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/features/project/presentation/models/project_create_state.dart';
import 'package:todomodu_app/features/project/presentation/providers/project_providers.dart';
import 'package:todomodu_app/features/project/presentation/viewmodels/project_loading_view_model.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project_create/project_todo_subtask_list.dart';
import 'package:todomodu_app/features/todo/domain/entities/subtask.dart';
import 'package:todomodu_app/features/todo/domain/entities/todo.dart';
import 'package:todomodu_app/features/user/presentation/pages/main/main_page.dart';
import 'package:todomodu_app/features/user/presentation/viewmodels/user_view_model.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';
import 'package:todomodu_app/shared/utils/navigate_to_page.dart';
import 'package:todomodu_app/shared/widgets/common_elevated_button.dart';

class ProjectCreateSubtaskPage extends ConsumerWidget {
  openai.OpenaiResponse response;
  ProjectCreateSubtaskPage({super.key, required this.response});

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
        leading: GestureDetector(
          onTap: () {
            // 🔄 로딩 상태 초기화
            ref.invalidate(projectProgressProvider);

            // 🧼 생성 상태 초기화 (ViewModel의 reset 사용)
            ref.invalidate(projectCreateViewModelProvider);
            ref.read(projectCreateViewModelProvider.notifier).reset();

            // 👈 메인으로 이동
            replaceAllWithPage(context, MainPage());
          },
          child: Icon(Icons.arrow_back_ios),
        ),
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

  Future<void> _createProject(
    WidgetRef ref,
    BuildContext context,
    ProjectCreateState state,
  ) async {
    //현재 유저 가지고 오기
    final userEntity =
        await ref.read(userViewModelProvider.notifier).fetchUser();
    if (userEntity == null) {
      throw Exception('프로젝트 생성에 필요한 필수 정보가 누락되었습니다.');
    }

    final random = Random();
    final color = colorList[random.nextInt(16)];
    final invitationCode = (random.nextInt(900000) + 100000).toString();
    List<Todo> finalTodos =
        state.selectedTodos.map((todoTitle) {
          // 서브테스크 형성
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

          // Chat GPT 응답으로부터 startDate, eadDate 값을 todo에 추가하기 위해 타이틀이 같은 responseTodo를 가지고 옴
          // responseTodo 의 startDate, endDate의 타입은 String (2025-04-20)
          final responseTodo =
              response.todos
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
    final project = Project(
      id: '',
      title: state.title,
      description: state.description,
      startDate: state.startDate ?? DateTime.parse(response.projectStartDate),
      endDate: state.endDate ?? DateTime.parse(response.projectStartDate),
      owner: userEntity,
      members: [userEntity],
      todos: finalTodos,
      invitationCode: invitationCode,
      isDone: false,
      color: color,
      progress: 0,
    );
    final createProjectUsecase = ref.read(createProjectUsecaseProvider);
    await ref
        .read(projectCreateViewModelProvider.notifier)
        .createProject(project, createProjectUsecase);

    ref.invalidate(hasFetchedProvider); // 새로 프로젝트를 불러올 수 있도록 상태 초기화

    // 🔄 로딩 상태 초기화
    ref.read(projectProgressProvider.notifier).reset();

    // 🧼 생성 상태 초기화 (ViewModel의 reset 사용)
    ref.read(projectCreateViewModelProvider.notifier).reset();
    ref.invalidate(projectCreateViewModelProvider);

    // 👈 메인으로 이동
    Future.microtask(() {
      replaceAllWithPage(context, MainPage());
    });
  }
}
