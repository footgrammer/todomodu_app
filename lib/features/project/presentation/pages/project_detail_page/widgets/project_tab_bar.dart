
import 'package:flutter/material.dart';

class ProjectTabBar extends StatelessWidget {
  const ProjectTabBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: const TabBar(
        labelColor: Colors.black87,
        unselectedLabelColor: Colors.grey,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: Colors.black87,
        tabs: [
          Tab(text: '할일'),
          Tab(text: '공지'),
          Tab(text: '타임라인'),
        ],
      ),
    );
  }
}
