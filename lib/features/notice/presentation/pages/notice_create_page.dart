import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/notice/presentation/providers/notice_providers.dart';
import 'package:todomodu_app/features/notice/presentation/widgets/notice_create_form.dart';

class NoticeCreatePage extends ConsumerWidget {
  const NoticeCreatePage({required this.projectId, super.key});
  final String projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = ref.watch(noticeCreateViewModelProvider(projectId).notifier);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('공지 작성하기')),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                NoticeCreateForm(
                  onTitleChanged: (title) {
                    viewmodel.setTitle(title);
                  },
                  onContentChanged: (content) {
                    viewmodel.setContent(content);
                  },
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    viewmodel.submit();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 56),
                    padding: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(),
                    ),
                    alignment: Alignment.center,
                  ),
                  child: Text('완료', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
