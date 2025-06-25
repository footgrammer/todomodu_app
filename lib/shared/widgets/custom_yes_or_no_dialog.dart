import 'package:flutter/material.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

Future<void> CustomYesOrNoDialog({
  required BuildContext context,
  required String title,
  required String message,
  required VoidCallback onPositivePressed,
  required VoidCallback onNegativePressed,
  String positiveText = '확인',
  String negativeText = '취소',
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title & Message
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 20),
              child: Column(
                children: [
                  Text(
                    title,
                    style: AppTextStyles.header4.copyWith(
                      color: AppColors.grey800,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body2.copyWith(
                      color: AppColors.grey800,
                    ),
                  ),
                ],
              ),
            ),

            // Divider
            const Divider(height: 1, color: AppColors.grey200),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: onNegativePressed,
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                        ),
                      ),
                    ),
                    child: Text(
                      negativeText,
                      style: AppTextStyles.header4.copyWith(
                        color: AppColors.grey400,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: onPositivePressed,
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.grey75,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                    ),
                    child: Text(
                      positiveText,
                      style: AppTextStyles.header4.copyWith(
                        color: AppColors.primary500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
