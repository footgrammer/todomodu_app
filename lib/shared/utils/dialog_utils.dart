import 'package:flutter/material.dart';

class DialogUtils {
  /// 에러 메시지용 다이얼로그
  static void showErrorDialog(
    BuildContext context,
    String message, {
    VoidCallback? onDismiss,
  }) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('알림'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // 다이얼로그 닫기
                  if (onDismiss != null) onDismiss(); // ✅ 닫은 후 추가 동작
                },
                child: const Text('확인'),
              ),
            ],
          ),
    );
  }

  /// 성공 메시지용 다이얼로그
  static void showSuccessDialog(
    BuildContext context,
    String message, {
    VoidCallback? onConfirm,
  }) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('성공'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onConfirm != null) onConfirm();
                },
                child: const Text('좋아요'),
              ),
            ],
          ),
    );
  }

  /// 사용자에게 질문하는 확인 다이얼로그 (예: 삭제 확인)
  static void showConfirmDialog(
    BuildContext context,
    String message, {
    required VoidCallback onYes,
    VoidCallback? onNo,
  }) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('확인'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onNo != null) onNo();
                },
                child: const Text('아니오'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onYes(); // 예 버튼은 무조건 필요
                },
                child: const Text('예'),
              ),
            ],
          ),
    );
  }
}
