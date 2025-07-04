import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/notice/presentation/providers/notice_providers.dart';
import 'package:todomodu_app/features/user/presentation/providers/user_providers.dart';

class PositionedRedDotForTab extends ConsumerWidget {
  const PositionedRedDotForTab({required this.projectId, super.key});

  final String projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProvider);
    final noticeState = ref.watch(
      noticeListForProjectViewModelProvider(projectId),
    );

    if (userAsync is! AsyncData || userAsync.value == null) {
      return const SizedBox.shrink();
    }

    final user = userAsync.value!;

    return noticeState.maybeWhen(
      data: (notices) {
        final hasUnread = notices.any(
          (n) => !n.checkedUsers.any((u) => u.userId == user.userId),
        );
        return hasUnread
            ? const Positioned(
              top: 0,
              right: 0,
              child: CircleAvatar(radius: 4, backgroundColor: Colors.red),
            )
            : const SizedBox.shrink();
      },
      orElse: () => const SizedBox.shrink(),
    );
  }
}
