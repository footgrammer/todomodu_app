import 'package:flutter/material.dart';
import 'package:todomodu_app/features/notice/domain/entities/notice.dart';
import 'package:todomodu_app/features/notice/presentation/widgets/notice_list/red_dot.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';
import 'package:todomodu_app/shared/utils/date_utils.dart';
import 'package:todomodu_app/shared/widgets/custom_icon.dart';

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
    final isUnread = !notice.checkedUsers.any((user) => user.userId == currentUser.userId);
    final checkSectionColor = AppColors.grey500;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.grey100,
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
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.grey600),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: checkSectionColor),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomIcon(
                      name: 'Circle_Check',
                      color: checkSectionColor,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '+${notice.checkedUsers.length} 명이 확인했어요!',
                      style: AppTextStyles.subtitle4.copyWith(
                        color: checkSectionColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (isUnread)
            const Align(alignment: Alignment.topRight, child: RedDot()),
        ],
      ),
    );
  }
}