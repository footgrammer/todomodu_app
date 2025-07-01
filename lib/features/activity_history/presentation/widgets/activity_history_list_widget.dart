import 'package:flutter/material.dart';
import 'package:todomodu_app/features/activity_history/domain/entities/activity_history.dart';
import 'package:todomodu_app/features/activity_history/presentation/widgets/activity_history_list_element.dart';
import 'package:todomodu_app/features/project/domain/entities/project.dart';

class ActivityHistoryListWidget extends StatelessWidget {
  const ActivityHistoryListWidget({
    super.key,
    required this.histories,
    required this.project,
  });

  final List<ActivityHistory> histories;
  final Project project;

  @override
  Widget build(BuildContext context) {
    if (histories.isEmpty) {
      return const Center(child: Text('활동 기록이 없습니다.'));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: histories.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return ActivityHistoryListElement(
          history: histories[index],
          projectName: project.title,
        );
      },
    );
  }
}
