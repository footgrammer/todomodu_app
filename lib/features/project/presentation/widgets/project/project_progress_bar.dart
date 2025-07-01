import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/features/project/domain/entities/project_extensions.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

class ProjectProgressBar extends ConsumerWidget {
  final Color textColor;
  final Project project;

  const ProjectProgressBar({
    super.key,
    required this.textColor,
    required this.project,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '진척도',
              style: AppTextStyles.subtitle3.copyWith(color: AppColors.grey900),
            ),
            Text(
              '${project.progressPercent}%',
              style: AppTextStyles.subtitle1.copyWith(color: AppColors.grey900),
            ),
          ],
        ),
        SizedBox(
          width: double.infinity,
          child: LinearProgressIndicator(
            value: project.progress,
            minHeight: 10,
            color: AppColors.grey700,
            backgroundColor: Color(0x40403F4B),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }
}
