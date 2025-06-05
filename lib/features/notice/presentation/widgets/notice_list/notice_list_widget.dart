import 'package:flutter/material.dart';
import 'package:todomodu_app/features/notice/domain/entities/notice.dart';
import 'package:todomodu_app/features/notice/presentation/widgets/notice_list/notice_list_widget_element.dart';

class NoticeListWidget extends StatelessWidget {
  NoticeListWidget({super.key});

  List<Notice> notices = [
    Notice(id: '1', projectId: '1', title: 'title', 
    content:
     """공지 내용1 지각금지
공지 내용2 지각비 100000원
공지 내용3 장난 치지 말것
공지 내용4 휴식시간은 12~1시
공지 내용5 저녁시간은 5~6시
퇴근 시간6 퇴근시간은 8시""", 
    checkedUsers: [], createdAt: DateTime.now()),
    Notice(id: '1', projectId: '1', title: 'title', content: 'content', checkedUsers: [], createdAt: DateTime.now()),
    Notice(id: '1', projectId: '1', title: 'title', content: 'content', checkedUsers: [], createdAt: DateTime.now()),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(itemBuilder: (context, index) {
        return NoticeListWidgetElement(notice: notices[index],);
      }, separatorBuilder: (context, index) {
        return SizedBox(height: 10,);
      }, itemCount: notices.length),
    );
  }
}