import 'package:flutter/material.dart';
import 'package:todomodu_app/features/notice/domain/entities/notice.dart';
import 'package:todomodu_app/shared/utils/date_utils.dart';

class NoticeForm extends StatelessWidget {
  const NoticeForm({required this.notice, super.key});
  final Notice notice;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(notice.title, style: Theme.of(context).textTheme.displayMedium),
        Text(
          formatDateDottedYMD(notice.createdAt),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(height: 24),
        Text(notice.content, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}
