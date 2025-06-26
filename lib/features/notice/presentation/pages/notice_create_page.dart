import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/notice/presentation/providers/notice_providers.dart';
import 'package:todomodu_app/features/notice/presentation/widgets/notice_create_form.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';
import 'package:todomodu_app/shared/types/result_extension.dart';

class NoticeCreatePage extends ConsumerWidget {
  const NoticeCreatePage({required this.projectId, super.key});
  final String projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = ref.watch(noticeCreateViewModelProvider(projectId).notifier);
    final noticeListVm = ref.read(noticeListViewModelProvider.notifier);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('공지 작성하기')),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              NoticeCreateForm(
                onTitleChanged: viewmodel.setTitle,
                onContentChanged: viewmodel.setContent,
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () async {
                  final result = await viewmodel.submit();

                  result.when(
                    ok: (notice) {
                      Navigator.pop(context, notice); // 작성 완료 시
                    },
                    error: (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('공지 생성 실패: $e')),
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary500,
                  minimumSize: Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  '완료',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
