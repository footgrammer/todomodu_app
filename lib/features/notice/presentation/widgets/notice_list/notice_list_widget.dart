import 'package:flutter/material.dart';
import 'package:todomodu_app/features/notice/domain/entities/notice.dart';
import 'package:todomodu_app/features/notice/presentation/pages/notice_detail_page.dart';
import 'package:todomodu_app/features/notice/presentation/widgets/notice_list/notice_list_widget_element.dart';
import 'package:todomodu_app/features/project/domain/entities/simple_project_info.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';

class NoticeListWidget extends StatelessWidget {
  const NoticeListWidget({required this.notices,required this.currentUser, required this.projects,super.key});

  final List<Notice> notices;
  final UserEntity currentUser;
  final List<SimpleProjectInfo> projects;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NoticeDetailPage(notice: notices[index],currentUser: currentUser,),
                ),
              );
            },
            child: NoticeListWidgetElement(
              notice: notices[index],
              currentUser: currentUser,
              key: ValueKey(notices[index].id),
              projectColor: projects.firstWhere((p) => p.id == notices[index].projectId).color,
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 10);
        },
        itemCount: notices.length,
      ),
    );
  }
}
