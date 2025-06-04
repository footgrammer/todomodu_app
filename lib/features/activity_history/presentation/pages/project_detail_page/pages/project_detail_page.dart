import 'package:flutter/material.dart';

class ProjectDetailPage extends StatelessWidget{
  const ProjectDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('프로젝트 상세'), // 나중에는 프로젝트 각 명칭으로 바꿔도 좋을 듯
          leading: const BackButton(),
          actions: const [
            Icon(Icons.more_vert),
            SizedBox(width: 8,)
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('프로젝트 1',
              style : TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('시작일',
                    style: TextStyle(color: Colors.black87),),
                    const SizedBox(height: 2,),
                    Text('년.월.일',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('종료일',
                    style: TextStyle(color: Colors.black87),),
                    const SizedBox(height: 2,),
                    Text('년.월.일',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('진척도', //진행도?
                    style: TextStyle(color: Colors.black87),),
                    const SizedBox(height: 2,),
                    Row(
                      children: [
                        Text('50%',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 8,),
                        SizedBox(
                          width: 60,
                          height: 6,
                          child: LinearProgressIndicator(
                            value: 0.5,
                            backgroundColor: Colors.grey[300],
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                    
                  ],
                ),
              ],
            ),),
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