import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

class TodoTitleInput extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final String? errorText;

  const TodoTitleInput({
    super.key,
    required this.controller,
    this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '할 일 이름',
          style: AppTextStyles.body3.copyWith(color: AppColors.grey500),
        ),
        SizedBox(height: 8,),
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(right: 60, bottom: 20),
              decoration: BoxDecoration(
                color: AppColors.grey50,
                border: Border.all(color: AppColors.grey200, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: controller,
                onChanged: onChanged,
                maxLength: 30,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                style: AppTextStyles.body2.copyWith(color: AppColors.grey800),
                decoration: InputDecoration(
                  hintText: errorText ?? '할 일 이름을 입력하세요',
                  hintStyle: AppTextStyles.body2.copyWith(
                    color: errorText != null ? Colors.red : AppColors.grey400,
                  ),
                  border: InputBorder.none,
                  counterText: '',
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 16,
              bottom: 8,
              child: Text(
                '${controller.text.length}/30',
                style: const TextStyle(fontSize: 12, color: AppColors.grey400),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
