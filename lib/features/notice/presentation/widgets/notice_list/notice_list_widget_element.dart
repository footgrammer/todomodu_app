import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/notice/domain/entities/notice.dart';
import 'package:todomodu_app/features/notice/domain/extensions/notice_extension.dart';
import 'package:todomodu_app/features/notice/presentation/providers/notice_providers.dart';
import 'package:todomodu_app/features/notice/presentation/widgets/notice_list/red_dot.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/shared/constants/app_colors.dart';
import 'package:todomodu_app/shared/utils/date_utils.dart';

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
            ],
          ),
          if (isUnread)
            const Align(alignment: Alignment.topRight, child: RedDot()),
        ],
      ),
    );
  }
}
