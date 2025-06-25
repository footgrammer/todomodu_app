import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/notice/domain/entities/notice.dart';
import 'package:todomodu_app/features/notice/presentation/providers/notice_providers.dart';
import 'package:todomodu_app/features/notice/presentation/widgets/notice_list/red_dot.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/shared/constants/app_colors.dart';
import 'package:todomodu_app/shared/utils/color_utils.dart';
import 'package:todomodu_app/shared/utils/date_utils.dart';

class NoticeListWidgetElement extends StatelessWidget {
  const NoticeListWidgetElement({
    required this.notice,
    required this.currentUser,
    super.key,
  });

  final Notice notice;
  final UserEntity currentUser;

  @override
  Widget build(BuildContext context) {
    final isUnread =
        !notice.checkedUsers.any((user) => user.userId == currentUser.userId);

    return Consumer(
      builder: (context, ref, child) {
        final noticeListVm = ref.watch(noticeListViewModelProvider.notifier);
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: noticeListVm.getColorByNotice(notice),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notice.title,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  Text(
                    formatDateDottedYMD(notice.createdAt),
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: AppColors.grey600),
                  ),
                ],
              ),
              if (isUnread)
                const Align(alignment: Alignment.topRight, child: RedDot()),
            ],
          ),
        );
      }
    );
  }
}
