
import 'package:flutter/material.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

class ProjectTabBar extends StatelessWidget {
  const ProjectTabBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const TabBar(
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
    );
  }
}
