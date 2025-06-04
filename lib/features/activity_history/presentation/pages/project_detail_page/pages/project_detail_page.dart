import 'package:flutter/material.dart';
import 'package:todomodu_app/features/activity_history/presentation/pages/project_detail_page/widgets/project_title_section.dart';

class ProjectDetailPage extends StatelessWidget{
  const ProjectDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('프로젝트 상세'), // 나중에는 프로젝트 로고?
          leading: const BackButton(),
          actions: const [
            Icon(Icons.more_vert),
            SizedBox(width: 8,)
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProjectTitleSection(),
            const SizedBox(height: 16,),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('팀원',
            style: TextStyle(fontSize: 16,
            fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2,),
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.orange[400],
                ),
                const Spacer(),
                OutlinedButton(
                  onPressed: () {}, 
                child: const Text('팀원 초대 +'),
                ),
              ],
            ),

          ],
        ),
        ),
        
        Padding(
          padding: const EdgeInsets.all(16),
          child: const TabBar(
            labelColor: Colors.black87,
            unselectedLabelColor: Colors.grey,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Colors.black87,
            tabs: [
              Tab(text: '할일'),
              Tab(text: '공지'),
              Tab(text: '타임라인'),
            ],),
        ),],
        ),
      ),
    );
  }

}