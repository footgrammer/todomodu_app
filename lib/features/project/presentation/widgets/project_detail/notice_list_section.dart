import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/notice/presentation/providers/notice_providers.dart';
import 'package:todomodu_app/features/notice/presentation/widgets/notice_list/notice_list_widget.dart';
import 'package:todomodu_app/features/user/presentation/providers/user_providers.dart';

class NoticeListSection extends ConsumerWidget {
  const NoticeListSection({required this.projectId, super.key});
  final String projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noticesAsync = ref.watch(
      noticeListForProjectViewModelProvider(projectId),
    );
    final userAsync = ref.watch(userProvider);

    if (userAsync is! AsyncData || userAsync.value == null) {
      return const SizedBox(); // 유저 정보 없으면 아무것도 안 보여줌
    }

    final currentUser = userAsync.value!;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 34),
      child: noticesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('에러: $e')),
        data:
            (notices) =>
                NoticeListWidget(notices: notices, currentUser: currentUser),
      ),
    );
  }
}
