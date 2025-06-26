import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

class EmptyProject extends StatelessWidget {
  const EmptyProject({super.key, required this.title, required this.subText, required this.image});

  final String title;
  final String subText;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            image,
            height: 92,
          ),
          SizedBox(height: 15),
          Text(
            title,
            style: AppTextStyles.body2.copyWith(color: AppColors.grey800),
          ),
          SizedBox(height: 4),
          Text(
            subText,
            style: AppTextStyles.caption1.copyWith(color: AppColors.grey500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
