import 'package:flutter/material.dart';
import 'package:todomodu_app/features/project/domain/entities/project.dart';


class ProjectChip extends StatelessWidget {
  const ProjectChip({required this.isChecked, required this.project, super.key});

  final bool isChecked;
  final Project project;

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
      child: Center(child: Text(project.title)),
    );
  }
}