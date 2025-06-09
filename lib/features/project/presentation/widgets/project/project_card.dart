import 'package:flutter/material.dart';
import 'package:todomodu_app/features/project/data/models/Project.dart';
import 'package:intl/intl.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project/project_member_icons.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project/project_progress_bar.dart';

final textColor = Color(0xFF28282F);

class ProjectCard extends StatelessWidget {
  final int index;
  final Project project;
  const ProjectCard({super.key, required this.index, required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
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
          ProjectProgressBar(textColor: textColor, project: project),
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
            style: TextStyle(
              color: textColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
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
      style: TextStyle(color: textColor, fontSize: 14),
    );
  }
}
