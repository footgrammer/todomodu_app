import 'package:flutter/material.dart';

class DualActionButtons extends StatelessWidget {
  const DualActionButtons({
    super.key,
    required this.onCancel,
    required this.onConfirm,
    this.cancelText = '취소',
    this.confirmText = '확인',
  });

  final VoidCallback onCancel;
  final VoidCallback onConfirm;
  final String cancelText;
  final String confirmText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: onCancel,
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFFCAC7DA),
              padding: const EdgeInsets.fromLTRB(0, 17.5, 0, 16.5),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                ),
              ),
            ),
            child: Text(
              cancelText,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: onConfirm,
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFFF0F0F3),
              foregroundColor: const Color(0xFF5752EA),
              padding: const EdgeInsets.fromLTRB(0, 17.5, 0, 16.5),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),
            child: Text(
              confirmText,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
