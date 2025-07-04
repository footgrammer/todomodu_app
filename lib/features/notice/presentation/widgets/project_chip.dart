import 'package:flutter/material.dart';
import 'package:todomodu_app/features/notice/presentation/widgets/notice_list/red_dot.dart';
import 'package:todomodu_app/features/project/domain/entities/simple_project_info.dart';
import 'package:todomodu_app/shared/constants/app_colors.dart';

class ProjectChip extends StatelessWidget {
  const ProjectChip({
    required this.project,
    required this.selected,
    required this.onTap,
    this.hasUnread = false,
    super.key,
  });

  final SimpleProjectInfo project;
  final bool selected;
  final VoidCallback onTap;
  final bool hasUnread;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ChoiceChip(
          label: Text(
            project.title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: selected ? AppColors.grey900 : AppColors.grey600,
            ),
          ),
          selected: selected,
          selectedColor: project.color,
          backgroundColor: AppColors.grey200,
          showCheckmark: false,
          shape: const StadiumBorder(side: BorderSide.none),
          onSelected: (_) => onTap(),
        ),
        if (hasUnread) const Positioned(top: 1, right: 1, child: RedDot()),
      ],
    );
  }
}
