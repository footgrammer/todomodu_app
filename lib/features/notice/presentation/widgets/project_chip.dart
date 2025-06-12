import 'package:flutter/material.dart';

class ProjectChip extends StatelessWidget {
  const ProjectChip({required this.isChecked, required this.projectName,super.key});

  final bool isChecked;
  final String projectName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black
        ),
        borderRadius: BorderRadius.circular(100)
      ),
      child: Center(child: Text(projectName)),
    );
  }
}