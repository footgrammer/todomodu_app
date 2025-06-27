import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/notice/domain/entities/notice.dart';
import 'package:todomodu_app/features/notice/domain/extensions/notice_extension.dart';
import 'package:todomodu_app/features/notice/presentation/providers/notice_providers.dart';
import 'package:todomodu_app/features/notice/presentation/widgets/notice_list/red_dot.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';
import 'package:todomodu_app/shared/utils/date_utils.dart';
import 'package:todomodu_app/shared/widgets/custom_icon.dart';

class NoticeListWidgetElement extends ConsumerWidget {
  const NoticeListWidgetElement({
    required this.notice,
    required this.currentUser,
    super.key,
  });

  final Notice notice;
  final UserEntity currentUser;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.read(noticeListViewModelProvider.notifier);
    final state = ref.watch(noticeListViewModelProvider);
    final latest = state.notices.firstWhereOrNull((n) => n.id == notice.id);
    final isUnread = latest?.isUnread(currentUser.userId) ?? false;
    final checkSectionColor = AppColors.grey500;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: vm.getColorByNotice(notice),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                latest?.title ?? '공지',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              Text(
                formatDateDottedYMD(latest?.createdAt ?? notice.createdAt),
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.grey600),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: checkSectionColor),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomIcon(name: 'Circle_Check', color: checkSectionColor, size: 16,),
                    SizedBox(width: 4),
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
