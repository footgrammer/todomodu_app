import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/notice/domain/entities/notice.dart';
import 'package:todomodu_app/features/notice/presentation/providers/notice_providers.dart';
import 'package:todomodu_app/features/notice/presentation/widgets/notice_form.dart';
import 'package:todomodu_app/features/notice/presentation/widgets/notice_list/expanded_text_box/notice_check_button.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';

class NoticeDetailPage extends ConsumerStatefulWidget {
  const NoticeDetailPage({
    required this.notice,
    required this.currentUser,
    super.key,
  });

  final Notice notice;
  final UserEntity currentUser;

  @override
  ConsumerState<NoticeDetailPage> createState() => _NoticeDetailPageState();
}

class _NoticeDetailPageState extends ConsumerState<NoticeDetailPage> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.notice.checkedUsers.any(
      (user) => user.userId == widget.currentUser.userId,
    );
  }

  void handleCheck() {
    if (isChecked) return;

    final vm = ref.read(noticeListViewModelProvider.notifier);
    vm.markNoticeAsRead(widget.notice); // ✅ ViewModel 내부에서 userProvider 사용

    setState(() {
      isChecked = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('공지 확인하기')),
      body: Align(
        alignment: Alignment.topLeft,
        child: IntrinsicWidth(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                NoticeForm(notice: widget.notice),
                const SizedBox(height: 50),
                NoticeCheckButton(
                  isChecked: isChecked,
                  onClickButton: handleCheck,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
