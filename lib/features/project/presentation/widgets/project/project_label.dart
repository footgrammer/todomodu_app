import 'package:flutter/material.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

class ProjectLabel extends StatelessWidget {
  String text;
  ProjectLabel({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return Text(text, style: AppTextStyles.body3);
  }
}
