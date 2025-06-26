import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/notice/presentation/providers/notice_providers.dart';
import 'package:todomodu_app/features/notice/presentation/widgets/notice_list/red_dot.dart';
import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/features/user/presentation/providers/user_providers.dart';
import 'package:todomodu_app/shared/constants/app_colors.dart';

class ProjectChip extends ConsumerWidget {
  const ProjectChip({required this.project, super.key});

  final Project project;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(noticeListViewModelProvider);
    final isSelected = state.selectedProjects.any((p) => p.id == project.id);
    final vm = ref.read(noticeListViewModelProvider.notifier);

    final userAsync = ref.watch(userProvider);

    if (userAsync is! AsyncData || userAsync.value == null) {
      return const SizedBox(); // 유저 정보 없으면 아무것도 안 보여줌
    }

    final currentUser = userAsync.value!;

    return Stack(
      children: [
        ChoiceChip(
          label: Text(
            project.title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isSelected ? AppColors.grey900 : AppColors.grey600,
            ),
          ),
          selected: isSelected,
          selectedColor: project.color,
          backgroundColor: AppColors.grey200,
          showCheckmark: false,
          shape: const StadiumBorder(side: BorderSide.none),
          onSelected: (selected) {
            if (selected) {
              vm.addProject(project);
            } else {
              vm.removeProject(project);
            }
          },
        ),
        if (vm.hasUnreadNotices(project, currentUser))
          const Positioned(
            top: 1, // 위치는 필요에 따라 조절
            right: 1, // 위치는 필요에 따라 조절
            child: RedDot(),
          ),
      ],
    );
  }
}
