import 'package:flutter/material.dart';
import 'package:todomodu_app/features/notice/presentation/widgets/project_chip.dart';
import 'package:todomodu_app/features/project/domain/entities/project.dart';


class ProjectChipList extends StatelessWidget {
  const ProjectChipList({required this.projects ,super.key});
  
  final List<Project> projects;

  // final List<String> projectNames = ['전체', '프로젝트1', '프로젝트2', '프로젝트 명이 너무 길면 어떻게 되는가'];

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 40),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return ProjectChip(isChecked: true, project: projects[index]);
        },
        separatorBuilder: (context, index) {
          return SizedBox(width: 10);
        },
        itemCount: projects.length,
      ),
    );
  }
}
