import 'package:flutter/material.dart';
import 'package:todomodu_app/shared/constants/app_colors.dart';
import 'package:todomodu_app/shared/widgets/custom_icon.dart';

class NoticeCheckButton extends StatelessWidget {
  const NoticeCheckButton({
    required this.isChecked,
    required this.onClickButton,
    super.key,
  });

  final bool isChecked;
  final void Function() onClickButton;

  @override
  Widget build(BuildContext context) {
    final Color currentColor = isChecked
        ? AppColors.grey800.withOpacity(0.5)
        : AppColors.primary600;

    final String buttonText =
        isChecked ? '확인했습니다!' : '확인했나요?';

    return GestureDetector(
      onTap: isChecked ? null : onClickButton,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: currentColor),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomIcon(name: 'Circle_Check', color: currentColor),
            const SizedBox(width: 4),
            Text(
              buttonText,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: currentColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
