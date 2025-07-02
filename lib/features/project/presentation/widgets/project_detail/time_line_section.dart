import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/activity_history/presentation/providers/activity_history_providers.dart';
import 'package:todomodu_app/features/activity_history/presentation/widgets/activity_history_list_widget.dart';
import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

class TimeLineSection extends ConsumerWidget {
  const TimeLineSection({required this.project, super.key});
  final Project project;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncHistories = ref.watch(activityHistoryListViewModelProvider(project.id));

    return Container(
      decoration: BoxDecoration(
        color: AppColors.grey75,
      ),
      child: asyncHistories.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('오류 발생: $e')),
        data: (histories) => ActivityHistoryListWidget(histories: histories, project: project,),
      ),
    );
  }
}
