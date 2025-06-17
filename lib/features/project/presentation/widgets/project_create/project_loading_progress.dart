import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/project/presentation/viewmodels/project_loading_view_model.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

class ProjectLoadingProgress extends ConsumerWidget {
  const ProjectLoadingProgress({super.key, required this.progress});

  final ProjectProgressState progress;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 180,
      height: 180,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox.expand(
            child: CircularProgressIndicator(
              value: progress.percent,
              strokeWidth: 8,
              valueColor: AlwaysStoppedAnimation(AppColors.primary500),
              backgroundColor: AppColors.grey200,
            ),
          ),
          Text(
            '${(progress.percent * 100).round()}%',
            style: AppTextStyles.header1,
          ),
        ],
      ),
    );
  }
}
