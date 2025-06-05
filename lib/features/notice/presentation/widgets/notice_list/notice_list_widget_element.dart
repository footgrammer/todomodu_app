import 'package:flutter/material.dart';
import 'package:todomodu_app/features/notice/domain/entities/notice.dart';

class NoticeListWidgetElement extends StatelessWidget {
  const NoticeListWidgetElement({required this.notice, super.key});
  final Notice notice;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.black
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(notice.title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
          Text(notice.content),
        ],
      ),
    );
  }
}