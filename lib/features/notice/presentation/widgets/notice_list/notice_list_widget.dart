import 'package:flutter/material.dart';
import 'package:todomodu_app/features/notice/domain/entities/notice.dart';
import 'package:todomodu_app/features/notice/presentation/widgets/notice_list/notice_list_widget_element.dart';

class NoticeListWidget extends StatelessWidget {
  NoticeListWidget({required this.notices, super.key});
  final notices;
//   List<Notice> notices = [
//     Notice(id: '1', projectId: '1', title: '타이틀이 엄청나게 길면 어떻게 할거야', 
//     content:
//      """공지 내용1 지각금지
// 공지 내용2 지각비 100000원
// 공지 내용3 장난 치지 말것
// 공지 내용4 휴식시간은 12~1시
// 공지 내용5 저녁시간은 5~6시
// 퇴근 시간6 퇴근시간은 8시""", 
//     checkedUsers: [], createdAt: DateTime.now()),
//     Notice(id: '2', projectId: '1', title: 'title', content: '그러면 한줄로 엄청 길게 쓴다면 어떻게 될지도 테스트를 해봐야 하잖아 그러면 한줄로 엄청 길게 쓴다면 어떻게 될지도 테스트를 해봐야 하잖아그러면 한줄로 엄청 길게 쓴다면 어떻게 될지도 테스트를 해봐야 하잖아그러면 한줄로 엄청 길게 쓴다면 어떻게 될지도 테스트를 해봐야 하잖아그러면 한줄로 엄청 길게 쓴다면 어떻게 될지도 테스트를 해봐야 하잖아그러면 한줄로 엄청 길게 쓴다면 어떻게 될지도 테스트를 해봐야 하잖아그러면 한줄로 엄청 길게 쓴다면 어떻게 될지도 테스트를 해봐야 하잖아그러면 한줄로 엄청 길게 쓴다면 어떻게 될지도 테스트를 해봐야 하잖아그러면 한줄로 엄청 길게 쓴다면 어떻게 될지도 테스트를 해봐야 하잖아그러면 한줄로 엄청 길게 쓴다면 어떻게 될지도 테스트를 해봐야 하잖아그러면 한줄로 엄청 길게 쓴다면 어떻게 될지도 테스트를 해봐야 하잖아', checkedUsers: [], createdAt: DateTime.now()),
//     Notice(id: '3', projectId: '1', title: 'title', content: 'content', checkedUsers: [], createdAt: DateTime.now()),
//   ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(itemBuilder: (context, index) {
        return NoticeListWidgetElement(notice: notices[index], key: ValueKey(notices[index].id),);
      }, separatorBuilder: (context, index) {
        return SizedBox(height: 10,);
      }, itemCount: notices.length),
    );
  }
}