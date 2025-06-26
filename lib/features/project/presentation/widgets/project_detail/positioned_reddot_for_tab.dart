import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/notice/presentation/providers/notice_providers.dart';
import 'package:todomodu_app/features/notice/presentation/widgets/notice_list/red_dot.dart';
import 'package:todomodu_app/features/user/presentation/providers/user_providers.dart';

class PositionedReddotForTab extends ConsumerWidget {
  const PositionedReddotForTab({required this.projectId, super.key});
  final String projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProvider);
    if (!userAsync.hasValue || userAsync.value == null) {
      return const SizedBox.shrink();
    }
    final currentUser = userAsync.value!;
    final hasUnread = ref
        .read(noticeListViewModelProvider.notifier)
        .hasUnreadNoticesforDetail(projectId, currentUser);
    return hasUnread ? const RedDot() : const SizedBox.shrink();
  }
}
