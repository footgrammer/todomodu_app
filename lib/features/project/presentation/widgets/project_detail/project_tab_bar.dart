import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/notice/presentation/providers/notice_providers.dart';
import 'package:todomodu_app/features/notice/presentation/widgets/notice_list/red_dot.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project_detail/notice_list_section.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project_detail/positioned_reddot_for_tab.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project_detail/todo_list_section.dart';
import 'package:todomodu_app/features/user/presentation/providers/user_providers.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

class ProjectTabBar extends StatelessWidget {
  final String projectId;

  const ProjectTabBar({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: TabBar(
            labelColor: AppColors.primary600,
            labelStyle: AppTextStyles.subtitle1,
            unselectedLabelColor: AppColors.grey400,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: AppColors.primary600,
            tabs: [
              Tab(text: '할 일'),
              Tab(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Text('공지'), // const 제거
                    Positioned(
                      top: -5,
                      right: -10,
                      child: PositionedReddotForTab(projectId: projectId),
                    ),
                  ],
                ),
              ),
              Tab(text: '타임라인'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            children: [
              TodoListSection(projectId: projectId),
              NoticeListSection(projectId: projectId),
              const Center(child: Text('타임라인 탭')),
            ],
          ),
        ),
      ],
    );
  }
}
