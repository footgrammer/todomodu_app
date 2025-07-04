import 'package:flutter/material.dart';
import 'package:todomodu_app/features/notice/presentation/widgets/project_chip.dart';
import 'package:todomodu_app/features/project/domain/entities/simple_project_info.dart';

class ProjectChipList extends StatelessWidget {
  const ProjectChipList({
    required this.projects,
    required this.selectedProjects,
    required this.onSelectedChanged,
    super.key,
  });

  final List<SimpleProjectInfo> projects;
  final List<SimpleProjectInfo> selectedProjects;
  final void Function(List<SimpleProjectInfo>) onSelectedChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 40),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: projects.length,
        itemBuilder: (context, index) {
          final project = projects[index];
          final isSelected = selectedProjects.contains(project);

          return ProjectChip(
            project: project,
            selected: isSelected,
            onTap: () {
              final newSelected = List<SimpleProjectInfo>.from(
                selectedProjects,
              );

              if (isSelected) {
                newSelected.remove(project);
              } else {
                newSelected.add(project);
              }

              onSelectedChanged(newSelected);
            },
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 10),
      ),
    );
  }
}
