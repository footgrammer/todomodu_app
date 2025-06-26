import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/notice/domain/extensions/notice_extension.dart';
import 'package:todomodu_app/features/notice/presentation/providers/notice_providers.dart';
import 'package:todomodu_app/features/notice/presentation/widgets/notice_list/red_dot.dart';
import 'package:todomodu_app/features/user/presentation/providers/user_providers.dart';

class PositionedReddotForTab extends ConsumerWidget {
  const PositionedReddotForTab({required this.projectId, super.key});
  final String projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProvider);
    final state = ref.watch(noticeListViewModelProvider); // ✅ state를 구독해야 rebuild됨

    if (!userAsync.hasValue || userAsync.value == null) {
      return const SizedBox.shrink();
    }

    final currentUser = userAsync.value!;
    final hasUnread = state.notices.any((notice) {
      return notice.projectId == projectId &&
             notice.isUnread(currentUser.userId);
    });

    return hasUnread ? const RedDot() : const SizedBox.shrink();
  }
}
