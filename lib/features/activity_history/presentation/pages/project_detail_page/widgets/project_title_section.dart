import 'package:flutter/material.dart';
import 'package:todomodu_app/features/activity_history/presentation/pages/project_detail_page/widgets/date_info.dart';

class ProjectTitleSection extends StatelessWidget{
  const ProjectTitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                DateInfo(label: '시작일', date: '년.월.일'), // entity 데이터 교체
                DateInfo(label: '종료일', date: '년.월.일'), // 추후 데이터 교체
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
      ],
    );
  }
}