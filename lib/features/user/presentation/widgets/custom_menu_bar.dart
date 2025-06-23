import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:todomodu_app/shared/constants/app_colors.dart';
import 'package:todomodu_app/shared/widgets/custom_icon.dart';

class CustomMenuBar extends StatelessWidget {
  const CustomMenuBar({super.key, required this.text, this.onPressed});

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: TextStyle(fontSize: 18)),
          IconButton(
            onPressed: () {
              log('메뉴바 버튼 클릭');
              onPressed?.call();
            },
            icon: CustomIcon(name: 'Chevron_Right', color: AppColors.grey400),
          ),
        ],
      ),
    );
  }
}
