import 'package:flutter/material.dart';

class ProjectLabel extends StatelessWidget {
  String text;
  ProjectLabel({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    final body3 = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Color(0xFF8C8AA0),
    );
    return Text(text, style: body3);
  }
}
