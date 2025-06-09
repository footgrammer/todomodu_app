import 'package:flutter/material.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project_detail/project_tab_bar.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project_detail/project_title_section.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project_detail/team_member_section.dart';
import 'package:todomodu_app/features/todo/presentation/pages/add_todo.dart';

class ProjectDetailPage extends StatelessWidget {
  const ProjectDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('프로젝트 상세'), // 나중에는 프로젝트 로고?
          leading: const BackButton(),
          actions: const [
            Icon(Icons.more_vert),
            SizedBox(
              width: 8,
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProjectTitleSection(), //프로젝트 제목, 시작일, 종료일, 진척도
            const SizedBox(
              height: 16,
            ),
            TeamMemberSection(), // 팀원 표시, 팀원 초대
            ProjectTabBar(), // 프로젝트 상세페이지 하단 탭 바
          ],
        ),
floatingActionButton: Container(
  height: 50,
  child: FloatingActionButton.extended(
            backgroundColor: Colors.grey[700],
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(44)
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddTodoPage(),)
              );
            },
            label: const Text('할 일 추가 +'),
          ),
),
    )
    );
  }
}
