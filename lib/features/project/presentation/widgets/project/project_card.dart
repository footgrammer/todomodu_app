import 'package:flutter/material.dart';
import 'package:todomodu_app/features/project/data/models/Project.dart';
import 'package:intl/intl.dart';

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
          getProjectTitle(),
          SizedBox(height: 4),
          getProjectTimePlan(),
          SizedBox(height: 16),
          // 진행도
          getProjectProgressBar(),
          SizedBox(height: 16),
          // 멤버 아이콘들
          getMemberIcons(),
        ],
      ),
    );
  }

  Row getMemberIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // 아바타 겹치기
        SizedBox(
          height: 24,
          width: 100, // 너비는 아바타 수에 따라 적절히 조절
          child: Stack(
            children: List.generate(3, (i) {
              return Positioned(
                left: i * 18, // 겹치는 정도 조절
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white, // 실제 이미지 대신 배경색
                    border: Border.all(color: Colors.white, width: 2),
                    image: DecorationImage(
                      image: AssetImage('assets/avatar_placeholder.png'), // 예시
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            })..add(
              // +n 동그라미
              Positioned(
                left: 3 * 18,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      '+3',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 36, height: 36, child: Icon(Icons.more_vert, size: 20)),
      ],
    );
  }

  Column getProjectProgressBar() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('진척도', style: TextStyle(color: textColor, fontSize: 14)),
            Text(
              '74%',
              style: TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),

        SizedBox(
          width: double.infinity,
          child: LinearProgressIndicator(
            value: 0.74,
            minHeight: 10,

            color: Colors.grey.shade800,
            backgroundColor: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }

  Text getProjectTimePlan() {
    return Text(
      '${DateFormat('yyyy.MM.dd').format(project.startDate)} - ${DateFormat('yyyy.MM.dd').format(project.endDate)}',
      style: TextStyle(color: textColor, fontSize: 14),
    );
  }

  Row getProjectTitle() {
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
}
