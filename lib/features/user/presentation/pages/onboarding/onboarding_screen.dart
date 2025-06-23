import 'package:flutter/material.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({
    super.key,
    required this.path,
    required this.title,
    required this.description,
  });

  final String path;
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 106),
          child: Image.asset(path),
        ),
        const SizedBox(height: 24),
        Text(
          title,
          style: AppTextStyles.header1.copyWith(color: AppColors.grey900),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          textAlign: TextAlign.center,
          style: AppTextStyles.body2.copyWith(color: AppColors.grey500),
        ),
      ],
    );
  }
}
