import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:todomodu_app/features/notice/presentation/providers/notice_providers.dart';
import 'package:todomodu_app/features/notice/presentation/widgets/notice_list/notice_list_widget.dart';
import 'package:todomodu_app/features/notice/presentation/widgets/project_chip_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/features/user/presentation/providers/user_providers.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';
import 'package:todomodu_app/shared/widgets/custom_icon.dart';

class NoticeListPage extends ConsumerStatefulWidget {
  const NoticeListPage({super.key});

  @override
  ConsumerState<NoticeListPage> createState() => _NoticeListPageState();
}

class _NoticeListPageState extends ConsumerState<NoticeListPage> {
  bool _initialized = false;

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<UserEntity?>>(userProvider, (prev, next) {
      final user = next.asData?.value;
      if (user != null && !_initialized) {
        _initialized = true;
        ref.read(noticeListViewModelProvider.notifier).initialize(user);
      }
    });

    final userAsync = ref.watch(userProvider);
    final noticeListState = ref.watch(noticeListViewModelProvider);
    final noticeListVm = ref.watch(noticeListViewModelProvider.notifier);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: const Text('공지', style: AppTextStyles.header3),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                log('알림 버튼 클릭');
              },
              child: Container(
                width: 36,
                height: 36,
                color: Colors.transparent,
                child: CustomIcon(name: 'bell'),
              ),
            ),
            SizedBox(width: 14),
          ],
        ),
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
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      ChoiceChip(
                        label: const Text('전체'),
                        selected: !noticeListVm.isAllProjectsSelected(),
                        showCheckmark: false,
                        shape: const StadiumBorder(side: BorderSide.none),
                        onSelected: (_) {
                          noticeListVm.onClickAllChip();
                        },
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ProjectChipList(
                          projects: noticeListState.projects,
                          selectedProjects: noticeListState.selectedProjects,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Divider(),
                const SizedBox(height: 10),
                Expanded(
                  child:
                      noticeListState.selectedNotices.isEmpty
                          ? const Center(child: Text('프로젝트를 선택하세요.'))
                          : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: NoticeListWidget(
                              notices: noticeListState.selectedNotices,
                              currentUser: user,
                            ),
                          ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
