import 'package:flutter/material.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

class Header extends StatelessWidget {
  final String userName;

  const Header({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$userName 님, 안녕하세요',
      style: AppTextStyles.body2.copyWith(color: AppColors.grey500),
    );
  }
}
