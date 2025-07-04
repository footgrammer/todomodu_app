import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/notice/presentation/providers/notice_providers.dart';
import 'package:todomodu_app/features/notice/presentation/widgets/notice_list/notice_list_widget.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project_detail/empty_notice.dart';
import 'package:todomodu_app/features/user/presentation/providers/user_providers.dart';
import 'package:todomodu_app/shared/constants/app_colors.dart';

class NoticeListSection extends ConsumerWidget {
  const NoticeListSection({required this.projectId, super.key});
  final String projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProvider);
    final viewModel = ref.read(noticeListViewModelProvider.notifier);

    if (userAsync is! AsyncData || userAsync.value == null) {
      return const SizedBox(); // 유저 정보 없으면 아무것도 안 보여줌
    }

    final currentUser = userAsync.value!;
    final notices = viewModel.getNoticesByProject(projectId); // ✅ ViewModel 사용
    final _ = ref.watch(noticeListViewModelProvider); // 상태변경을 위해 선언만

    return Container(
      decoration: BoxDecoration(
        color: AppColors.grey75,
      ),
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 34),
      child:
          notices.isEmpty
              ? EmptyNotice()
              : NoticeListWidget(
                isDetail: true,
                notices: notices,
                currentUser: currentUser,
              ),
    );
  }
}
