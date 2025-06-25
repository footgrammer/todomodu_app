import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/notice/presentation/providers/notice_providers.dart';
import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/shared/constants/app_colors.dart';
import 'package:todomodu_app/shared/utils/color_utils.dart';

class ProjectChip extends ConsumerWidget {
  const ProjectChip({ 
    required this.project, 
    super.key,
  });

  final Project project;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1) ViewModel 상태 구독
    final state = ref.watch(noticeListViewModelProvider);
    final isSelected = state.selectedProjects.any((p) => p.id == project.id);

    // 2) 액션 호출은 read로
    final vm = ref.read(noticeListViewModelProvider.notifier);

    return ChoiceChip(
      label: Text(
        project.title,
        style: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(color: isSelected 
                ? AppColors.grey900 
                : AppColors.grey600),
      ),
      selected: isSelected,
      selectedColor: project.color,
      backgroundColor: AppColors.grey200,
      showCheckmark: false,
      shape: StadiumBorder(
        side: BorderSide.none,
      ),
      onSelected: (selected) {
        if (selected) {
          vm.addProject(project);
        } else {
          vm.removeProject(project);
        }
      },
    );
  }
}
