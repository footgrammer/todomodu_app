import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/project/data/models/project_dto.dart';
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
  const ProjectCard({super.key, required this.index, required this.project});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        _handleJoinProject(ref, context);
      },
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: project.color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 제목 + 알림 + 메뉴
            _getProjectTitle(),
            SizedBox(height: 4),
            _getProjectTimePlan(),
            SizedBox(height: 16),
            // 진행도
            ProjectProgressBar(textColor: AppColors.grey900, project: project),
            SizedBox(height: 16),
            // 멤버 아이콘들
            ProjectMemberIcons(),
          ],
        ),
      ),
    );
  }

  Row _getProjectTitle() {
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
        Icon(Icons.notifications_none, size: 20),
        SizedBox(width: 8),
      ],
    );
  }

  Text _getProjectTimePlan() {
    return Text(
      '${DateFormat('yyyy.MM.dd').format(project.startDate)} - ${DateFormat('yyyy.MM.dd').format(project.endDate)}',
      style: AppTextStyles.body3.copyWith(color: AppColors.grey700),
    );
  }

  // 프로젝트 참가여부를 묻는 메서드
  void _handleJoinProject(WidgetRef ref, BuildContext context) async {
    // 1. 팀원인지 체크하기
    // 내 정보 가지고 오기
    final user = await ref.read(userViewModelProvider.notifier).fetchUser();
    if (user == null) return null;
    // 프로젝트 팀원 여부
    final isMyIdIncluded = project.members.any(
      (member) => member.userId == user.userId,
    );
    if (isMyIdIncluded) {
      // 팀원이면
      navigateToPage(context, ProjectDetailPage(project: project));
    } else {
      // 팀원이 아니면 가입 다이얼로그 띄우기
      CustomYesOrNoDialog(
        context: context,
        title: '프로젝트 참여',
        message: '이 프로젝트에 참여하시겠습니까?',
        onPositivePressed: () async {
          // 참여 로직
          final user =
              await ref.read(userViewModelProvider.notifier).fetchUser();
          if (user == null) return;
          ref
              .read(projectListViewModelProvider.notifier)
              .addMemberToProject(projectId: project.id, userId: user.userId);

          replaceAllWithPage(context, ProjectDetailPage(project: project));
        },
        onNegativePressed: () {
          // 취소 로직
          Navigator.pop(context);
        },
        positiveText: "참가하기",
      );
    }
  }
}
