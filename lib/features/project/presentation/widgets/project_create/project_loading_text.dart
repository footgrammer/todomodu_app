import 'package:flutter/material.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

class ProjectLoadingText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '할 일 목록 생성 중...',
          style: AppTextStyles.header1.copyWith(color: AppColors.grey800),
        ),
        SizedBox(height: 4),
        Text(
          '프로젝트에 딱 맞는 할 일을 찾고 있어요',
          style: AppTextStyles.body2.copyWith(color: AppColors.grey500),
        ),
      ],
    );
  }
}
