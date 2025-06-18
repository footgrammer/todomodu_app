import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';
import 'package:todomodu_app/shared/utils/date_utils.dart';

class ProjectDateBox extends ConsumerWidget {
  final DateTime? date;

  const ProjectDateBox(this.date, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 56,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.grey50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey200),
      ),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: Text(
              formatDateYMD(date),
              style: AppTextStyles.body2.copyWith(color: AppColors.grey800),
            ),
          ),
          SizedBox(width: 4),
          Icon(Icons.calendar_month),
        ],
      ),
    );
  }
}
