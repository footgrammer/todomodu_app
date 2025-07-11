import 'package:flutter/material.dart';
import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project_detail/notice_list_section.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project_detail/positioned_reddot_for_tab.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project_detail/time_line_section.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project_detail/todo_list_section.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

class ProjectTabBar extends StatelessWidget {
  final Project project;
  final TabController tabController; // ✅ 추가

  const ProjectTabBar({
    super.key,
    required this.project,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: TabBar(
            controller: tabController, // ✅ 연결
            labelColor: AppColors.primary600,
            labelStyle: AppTextStyles.subtitle1,
            unselectedLabelColor: AppColors.grey400,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: AppColors.primary600,
            tabs: [
              const Tab(text: '할 일'),
              Tab(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Text('공지'),
                    Positioned(
                      top: -5,
                      right: -10,
                      child: PositionedRedDotForTab(projectId: project.id),
                    ),
                  ],
                ),
              ),
              const Tab(text: '타임라인'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: tabController, // ✅ 연결
            children: [
              TodoListSection(projectId: project.id),
              NoticeListSection(project: project),
              TimeLineSection(project: project),
            ],
          ),
        ),
      ],
    );
  }
}
