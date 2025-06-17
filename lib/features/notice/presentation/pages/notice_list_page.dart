import 'package:flutter/material.dart';
import 'package:todomodu_app/features/notice/presentation/providers/notice_providers.dart';
import 'package:todomodu_app/features/notice/presentation/widgets/notice_list/notice_list_widget.dart';
import 'package:todomodu_app/features/notice/presentation/widgets/notice_searchbar.dart';
import 'package:todomodu_app/features/notice/presentation/widgets/project_chip_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/features/user/presentation/providers/user_providers.dart';

class NoticeListPage extends ConsumerStatefulWidget {
  const NoticeListPage({super.key});

  @override
  ConsumerState<NoticeListPage> createState() => _NoticeListPageState();
}

class _NoticeListPageState extends ConsumerState<NoticeListPage> {
  bool _initialized = false;

  @override
  Widget build(BuildContext context) {
    // build 내부에서만 ref.listen 사용!
    ref.listen<AsyncValue<UserEntity?>>(userProvider, (prev, next) {
      final user = next.asData?.value;
      if (user != null && !_initialized) {
        _initialized = true;
        ref.read(noticeListViewModelProvider.notifier).initialize(user);
      }
    });

    final userAsync = ref.watch(userProvider);
    final noticeListState = ref.watch(noticeListViewModelProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('공지')),
        body: userAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('에러 발생: $e')),
          data: (user) {
            if (user == null) {
              return const Center(child: Text('로그인이 필요합니다.'));
            }
            if (noticeListState.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (noticeListState.error != null) {
              return Center(child: Text('에러: ${noticeListState.error}'));
            }
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  NoticeSearchbar(),
                  const SizedBox(height: 20),
                  ProjectChipList(projects: noticeListState.projects),
                  const SizedBox(height: 20),
                  Expanded(
                    child: noticeListState.projects.isEmpty
                        ? const Center(child: Text('프로젝트를 선택하세요.'))
                        : NoticeListWidget(notices: noticeListState.notices),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

