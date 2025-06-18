import 'package:flutter/material.dart';
import 'package:todomodu_app/features/notice/domain/entities/notice.dart';
import 'package:todomodu_app/features/notice/presentation/widgets/notice_list/expanded_text_box/expanded_text_widget.dart';
import 'package:todomodu_app/shared/constants/app_colors.dart';
import 'package:todomodu_app/shared/utils/color_utils.dart';
import 'package:todomodu_app/shared/utils/date_utils.dart';

class NoticeListWidgetElement extends StatelessWidget {
  const NoticeListWidgetElement({required this.notice, super.key});
  final Notice notice;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color : brightPastelFromSeed(notice.projectId),
        borderRadius: BorderRadius.circular(12),
        // border: Border.all(color: AppColors.grey600),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            notice.title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            formatDateDottedYMD(notice.createdAt),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.grey600),
          ),
          SizedBox(height: 8),
          ExpandedTextWidget(content: notice.content),
        ],
      ),
    );
  }
}
