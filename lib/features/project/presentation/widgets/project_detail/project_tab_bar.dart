import 'package:flutter/material.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project_detail/todo_list_section.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

class ProjectTabBar extends StatelessWidget {
  final String projectId;

  const ProjectTabBar({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TabBar(
          labelColor: AppColors.primary600,
          labelStyle: AppTextStyles.subtitle1,
          unselectedLabelColor: AppColors.grey400,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: AppColors.primary600,
          tabs: [
            Tab(text: '할 일'),
            Tab(text: '공지'),
            Tab(text: '타임라인'),
          ],
        ),
        Expanded(
          child: TabBarView(
            children: [
              TodoListSection(projectId: projectId),
              const Center(child: Text('공지 탭')),
              const Center(child: Text('타임라인 탭')),
            ],
          ),
        ),
      ],
    );
  }
}
