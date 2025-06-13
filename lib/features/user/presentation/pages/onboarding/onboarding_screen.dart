import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todomodu_app/shared/constants/app_colors.dart';

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
        Spacer(),
        Spacer(),
        Spacer(),
        SvgPicture.asset(path),
        const SizedBox(height: 16),
        Text(
          title,
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: AppColors.grey600),
        ),
        Spacer(),
      ],
    );
  }
}
