import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

class EmptyProject extends StatelessWidget {
  const EmptyProject({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/project_list_empty_img.svg',
            height: 92,
          ),
          SizedBox(height: 15),
          Text(
            '아직 등록된 프로젝트가 없습니다.',
            style: AppTextStyles.body2.copyWith(color: AppColors.grey800),
          ),
          SizedBox(height: 4),
          Text(
            '프로젝트를 생성하여\n오늘의 할 일을 만들어 보세요!',
            style: AppTextStyles.caption1.copyWith(color: AppColors.grey500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
