import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/notice/presentation/models/notice_list_model_extension.dart';
import 'package:todomodu_app/features/notice/presentation/providers/notice_providers.dart';
import 'package:todomodu_app/features/notice/presentation/widgets/notice_list/notice_list_widget.dart';
import 'package:todomodu_app/features/notice/presentation/widgets/project_chip_list.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';


class NoticeListPage extends ConsumerWidget {
  const NoticeListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(noticeListViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('공지', style: AppTextStyles.header3),
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('에러: $e')),
        data: (model) => Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 34),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProjectChipList(
                projects: model.projects,
                selectedProjects: model.selectedProjects,
                onSelectedChanged: (newSelected) {
                  ref.read(noticeListViewModelProvider.notifier)
                      .updateSelectedProjects(newSelected);
                },
              ),
              const SizedBox(height: 20),
              Expanded(
                child: NoticeListWidget(
                  notices: model.filteredNotices,
                  currentUser: model.currentUser,
                  projects: model.projects,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

