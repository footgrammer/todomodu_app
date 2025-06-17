import 'package:flutter/material.dart';

class ProjectLoadingText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '할 일 목록 생성 중...',
          style: TextStyle(
            color: Color(0xFF403F4B),
            fontSize: 28,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 4),
        Text(
          '프로젝트에 딱 맞는 할 일을 찾고 있어요',
          style: TextStyle(
            color: Color(0xFF8C8AA0),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
