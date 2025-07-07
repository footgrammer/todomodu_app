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
    final isAllSelected = selectedProjects.length == projects.length;

    return Container(
      constraints: const BoxConstraints(maxHeight: 40),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: projects.length + 1, // ✅ 전체 Chip 추가
        itemBuilder: (context, index) {
          if (index == 0) {
            // ✅ 전체 Chip
            return GestureDetector(
              onTap: () {
                if (isAllSelected) {
                  onSelectedChanged([]);
                } else {
                  onSelectedChanged(List.of(projects));
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color:
                      isAllSelected
                          ? Theme.of(context).primaryColor
                          : Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '전체',
                  style: TextStyle(
                    color: isAllSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }

          final project = projects[index - 1]; // ✅ index 보정
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
