import 'package:flutter/material.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

class DatePickerBox extends StatelessWidget {
  final DateTime date;
  final VoidCallback onTap;

  const DatePickerBox({required this.date, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    String formatted =
        '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';

    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.grey50,
          border: Border.all(color: AppColors.grey200, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(formatted, style: AppTextStyles.body2.copyWith(color: AppColors.grey800),),
            Icon(Icons.calendar_month_outlined, size: 24),
          ],
        ),
      ),
    );
  }
}
