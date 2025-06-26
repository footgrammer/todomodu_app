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

    final userAsync = ref.watch(userProvider);

    if (userAsync is! AsyncData || userAsync.value == null) {
      return const SizedBox(); // 유저 정보 없으면 아무것도 안 보여줌
    }
    final currentUser = userAsync.value!;
    final vm = ref.read(noticeListViewModelProvider.notifier);

    return Container(
      padding: EdgeInsets.fromLTRB(24, 16, 24, 34),
      child: NoticeListWidget(notices: vm.getNoticesByProject(projectId), currentUser: currentUser,),
    );
  }
}