import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project_detail/project_tab_bar.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project_detail/project_title_section.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project_detail/team_member_section.dart';
import 'package:todomodu_app/features/todo/domain/entities/todo.dart';
import 'package:todomodu_app/features/todo/presentation/pages/add_todo_page.dart';
import 'package:todomodu_app/features/todo/presentation/providers/todo_list_viewmodel_provider.dart';
import 'package:todomodu_app/features/todo/presentation/widgets/todo_card.dart';

class ProjectDetailPage extends ConsumerWidget {
  final String projectId;

  const ProjectDetailPage({super.key, required this.projectId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(todoListViewModelProvider);
    final todosStream = viewModel.todosStream(projectId);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('프로젝트 상세'),
          leading: const BackButton(),
          actions: const [Icon(Icons.more_vert), SizedBox(width: 8)],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProjectTitleSection(),
            const SizedBox(height: 16),
            TeamMemberSection(),
            ProjectTabBar(),
            Expanded(
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
                    return const Center(child: Text('할 일이 없습니다.'));
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      final todo = todos[index];
                      return TodoCard(todo: todo);
                    },
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: Container(
          height: 50,
          child: FloatingActionButton.extended(
            backgroundColor: Colors.grey[700],
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(44),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTodoPage(projectId: projectId),
                ),
              );
            },
            label: const Text('할 일 추가 +'),
          ),
        ),
      ),
    );
  }
}
