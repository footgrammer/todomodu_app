import 'package:flutter/material.dart';
import 'package:todomodu_app/features/project/data/models/project_dto.dart';
import 'package:intl/intl.dart';
import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project/project_member_icons.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project/project_progress_bar.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

class ProjectCard extends StatelessWidget {
  final int index;
  final Project project;
  const ProjectCard({super.key, required this.index, required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
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
}
