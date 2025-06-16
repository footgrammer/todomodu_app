import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/project/presentation/viewmodels/project_create_view_model.dart';
import 'package:todomodu_app/features/project/presentation/widgets/form_fields/project_todo_subtask_list.dart';
import 'package:todomodu_app/shared/widgets/common_elevated_button.dart';

TextStyle header2 = TextStyle(fontSize: 24, fontWeight: FontWeight.w600);
TextStyle subTitle1 = TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
TextStyle subTitle2 = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
TextStyle subTitle3 = TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
Color grey900 = Color(0xFF28282F);
Color grey800 = Color(0xFF403F4B);
Color grey500 = Color(0xFF8C8AA0);
Color grey300 = Color(0xFFCAC7DA);
Color grey200 = Color(0xFFDCDBE4);
Color grey75 = Color(0xFFF0F0F3);
Color grey50 = Color(0xFFF7F7F8);
Color primary600 = Color(0xFF342DE7);
Color primary500 = Color(0xFF5752EA);

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
      appBar: AppBar(title: Row(children: [Text('프로젝트 추가하기', style: header2)])),
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('할 일을 더 자세히 나눠볼까요?', style: header2),
            const SizedBox(height: 8),
            Text(
              '선택한 일들을 조금 더 구체적으로 쪼개봤어요.\n아래 세부 항목 중 지금 꼭 필요한 것만 골라주세요.',
              style: subTitle3.copyWith(color: grey500),
            ),
            const SizedBox(height: 80),
            ProjectTodoSubtaskList(
              selectedTodos: selectedTodos,
              state: state,
              todoToAllSubtasks: todoToAllSubtasks,
              viewModel: viewModel,
              ref: ref,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 40, top: 10),
              child: CommonElevatedButton(
                text: '완료',
                buttonColor: primary500,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
