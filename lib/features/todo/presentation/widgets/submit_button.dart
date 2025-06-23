import 'package:flutter/material.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

class SubmitButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool enabled; 

  const SubmitButton({
    required this.label,
    required this.onPressed,
    this.enabled = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 58),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                enabled ? AppColors.primary600 : AppColors.grey100,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: enabled ? onPressed : null,
          child: Text(
            label,
            style: AppTextStyles.subtitle1.copyWith(
              color: enabled ? Colors.white : AppColors.grey400,
            ),
          ),
        ),
      ),
    );
  }
}
