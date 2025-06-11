import 'dart:developer';

import 'package:flutter/material.dart';

class CustomMenuBar extends StatelessWidget {
  const CustomMenuBar({super.key, required this.text});

  final String text;

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
            },
            icon: Icon(Icons.chevron_right, size: 24),
          ),
        ],
      ),
    );
  }
}
