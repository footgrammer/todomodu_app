import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/notice/presentation/providers/notice_providers.dart';
import 'package:todomodu_app/features/notice/presentation/widgets/notice_create_form.dart';
import 'package:todomodu_app/features/user/presentation/providers/user_providers.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';
import 'package:todomodu_app/shared/types/result_extension.dart';

class NoticeCreatePage extends ConsumerStatefulWidget {
  const NoticeCreatePage({required this.projectId, super.key});
  final String projectId;

  @override
  ConsumerState<NoticeCreatePage> createState() => _NoticeCreatePageState();
}

class _NoticeCreatePageState extends ConsumerState<NoticeCreatePage> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewmodel = ref.watch(
      noticeCreateViewModelProvider(widget.projectId).notifier,
    );
    final userAsync = ref.watch(userProvider);

    if (userAsync is! AsyncData || userAsync.value == null) {
      return const SizedBox(); // 유저 정보 없으면 아무것도 안 보여줌
    }

    final currentUser = userAsync.value!;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(title: const Text('공지 작성하기')),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            controller: _scrollController,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                NoticeCreateForm(
                  onTitleChanged: viewmodel.setTitle,
                  onContentChanged: viewmodel.setContent,
                ),
                const SizedBox(height: 80), // 키보드와 겹치지 않게 하단 공간 확보
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          minimum: EdgeInsets.fromLTRB(
            20,
            12,
            20,
            20 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: ElevatedButton(
            onPressed: () async {
              final result = await viewmodel.submit(currentUser);
      
              result.when(
                ok: (notice) {
                  Navigator.pop(context, notice);
                },
                error: (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('공지 생성 실패: $e')));
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary500,
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              '완료',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
