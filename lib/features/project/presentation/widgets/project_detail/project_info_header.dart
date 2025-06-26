import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

class ProjectInfoHeader extends StatelessWidget {
  final Project project;

  const ProjectInfoHeader({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final startDate = DateFormat('yyyy.MM.dd').format(project.startDate);
    final endDate = DateFormat('yyyy.MM.dd').format(project.endDate);
    final progress = project.progress;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          project.title,
          style: AppTextStyles.header2.copyWith(color: AppColors.grey800),
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _dateColumn('시작일', startDate),
            _dateColumn('종료일', endDate),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '진척도',
                  style: AppTextStyles.subtitle3.copyWith(color: AppColors.grey500),
                ),
                Row(
                  children: [
                    Text(
                      '${(progress * 100).round()}%',
                      style: AppTextStyles.body2.copyWith(color: AppColors.grey800),
                    ),
                    const SizedBox(width: 7),
                    SizedBox(
                      width: 56,
                      height: 8,
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: AppColors.grey200,
                        color: AppColors.primary500,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _dateColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.subtitle3.copyWith(color: AppColors.grey500)),
        Text(value, style: AppTextStyles.body2.copyWith(color: AppColors.grey800)),
      ],
    );
  }
}
