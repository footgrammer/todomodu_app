import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/features/project/presentation/pages/project_detail_page.dart';
import 'package:todomodu_app/features/project/presentation/providers/project_providers.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project/project_member_icons.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project/project_progress_bar.dart';
import 'package:todomodu_app/features/user/presentation/viewmodels/user_view_model.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';
import 'package:todomodu_app/shared/utils/navigate_to_page.dart';
import 'package:todomodu_app/shared/widgets/custom_yes_or_no_dialog.dart';

class ProjectCard extends ConsumerWidget {
  final int index;
  final Project project;

  const ProjectCard({
    super.key,
    required this.index,
    required this.project,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncProject = ref.watch(projectProvider(project.id));

    return asyncProject.when(
      data: (liveProject) => GestureDetector(
        onTap: () => handleJoinProject(ref, context, liveProject),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: liveProject.color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getProjectTitle(liveProject),
              const SizedBox(height: 4),
              _getProjectTimePlan(liveProject),
              const SizedBox(height: 16),
              ProjectProgressBar(textColor: AppColors.grey900, project: liveProject),
              const SizedBox(height: 16),
              ProjectMemberIcons(members: liveProject.members),
            ],
          ),
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('에러 발생: $e')),
    );
  }

  Row _getProjectTitle(Project project) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            project.title,
            style: AppTextStyles.header4,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Text _getProjectTimePlan(Project project) {
    return Text(
      '${DateFormat('yyyy.MM.dd').format(project.startDate)} - ${DateFormat('yyyy.MM.dd').format(project.endDate)}',
      style: AppTextStyles.body3.copyWith(color: AppColors.grey700),
    );
  }

  void handleJoinProject(WidgetRef ref, BuildContext context, Project project) async {
    final user = await ref.read(userViewModelProvider.notifier).fetchUser();
    if (user == null) return;

    final isMyIdIncluded = project.members.any(
      (member) => member.userId == user.userId,
    );

    if (isMyIdIncluded) {
      navigateToPage(context, ProjectDetailPage(project: project));
    } else {
      CustomYesOrNoDialog(
        context: context,
        title: '프로젝트 참여',
        message: '이 프로젝트에 참여하시겠습니까?',
        onPositivePressed: () async {
          final user = await ref.read(userViewModelProvider.notifier).fetchUser();
          if (user == null) return;

          ref.read(projectListViewModelProvider.notifier)
              .addMemberToProject(projectId: project.id, userId: user.userId);

          replaceAllWithPage(context, ProjectDetailPage(project: project));
        },
        onNegativePressed: () {
          Navigator.pop(context);
        },
        positiveText: "참가하기",
      );
    }
  }
}
