import 'package:flutter/material.dart';
import 'package:todomodu_app/features/activity_history/presentation/pages/project_detail_page/widgets/date_info.dart';
import 'package:todomodu_app/features/activity_history/presentation/pages/project_detail_page/widgets/progress_view.dart';
import 'package:todomodu_app/features/activity_history/presentation/pages/project_detail_page/widgets/project_name.dart';


class ProjectTitleSection extends StatelessWidget{
  const ProjectTitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
            ProjectName(title: '프로젝트 2'), // 추후 변경
            Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DateInfo(label: '시작일', date: '년.월.일'), // entity 데이터 교체
                DateInfo(label: '종료일', date: '년.월.일'), // 추후 데이터 교체
                const ProgressView(progress: 0.6) // 추후 데이터 교체
              ],
            ),),
      ],
    );
  }
}

