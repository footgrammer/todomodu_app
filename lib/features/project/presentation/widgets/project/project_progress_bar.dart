import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/project/data/models/Project.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

class ProjectProgressBar extends ConsumerWidget {
  Color textColor;
  Project project;

  ProjectProgressBar({
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
              '74%',
              style: AppTextStyles.subtitle1.copyWith(color: AppColors.grey900),
            ),
          ],
        ),

        SizedBox(
          width: double.infinity,
          child: LinearProgressIndicator(
            value: 0.74,
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
