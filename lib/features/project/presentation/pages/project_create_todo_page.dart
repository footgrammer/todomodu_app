import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/project/presentation/pages/project_create_subtask_page.dart';
import 'package:todomodu_app/features/project/presentation/viewmodels/project_create_view_model.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project_create/project_todo_list.dart';
import 'package:todomodu_app/shared/widgets/common_elevated_button.dart';

TextStyle header2 = TextStyle(fontSize: 24, fontWeight: FontWeight.w600);
TextStyle subTitle1 = TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
TextStyle subTitle2 = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
TextStyle subTitle3 = TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
Color grey800 = Color(0xFF403F4B);
Color grey500 = Color(0xFF8C8AA0);
Color grey300 = Color(0xFFCAC7DA);
Color grey75 = Color(0xFFF0F0F3);
Color primary600 = Color(0xFF342DE7);
Color primary500 = Color(0xFF5752EA);

class ProjectCreateTodoPage extends ConsumerWidget {
  final Map<String, dynamic> apiResult;

  const ProjectCreateTodoPage({super.key, required this.apiResult});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = apiResult['todos'] as List<dynamic>;
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
      appBar: AppBar(title: Row(children: [Text('프로젝트 추가하기', style: header2)])),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '이 프로젝트엔\n어떤 일이 필요할까요?',
              style: header2.copyWith(color: grey800),
            ),
            const SizedBox(height: 8),
            Text(
              '프로젝트 내용을 바탕으로 할 일을 추천해봤어요.\n꼭 필요한 것만 골라주세요!',
              style: subTitle3.copyWith(color: grey500),
            ),
            const SizedBox(height: 48),
            ProjectTodoList(
              todos: todos,
              selectedTodos: selectedTodos,
              viewModel: viewModel,
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: 40, top: 10),
              child: CommonElevatedButton(
                text: '다음',
                buttonColor: primary500,
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
