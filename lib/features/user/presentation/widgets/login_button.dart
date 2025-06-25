import 'package:flutter/material.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.path,
    required this.onPressed,
    required this.platform,
    this.color = Colors.white,
  });

  final String path;
  final VoidCallback onPressed;
  final String platform;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          elevation: 0,
          minimumSize: Size.fromHeight(56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(color: AppColors.grey200),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox.square(
              dimension: 24,
              child: Image.asset(path, fit: BoxFit.contain),
            ),
            const SizedBox(width: 8),
            Text(
              '$platform 로그인하기',
              style: AppTextStyles.subtitle1.copyWith(color: AppColors.grey900),
            ),
          ],
        ),
      ),
    );
  }
}
