import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todomodu_app/features/notice/presentation/providers/notice_providers.dart';
import 'package:todomodu_app/features/project/presentation/pages/project_create_page.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project/project_card_list.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project/project_search_bar.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/features/user/presentation/providers/user_providers.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';
import 'package:todomodu_app/shared/utils/navigate_to_page.dart';
import 'package:todomodu_app/shared/widgets/custom_icon.dart';

final projectCodeControllerProvider =
    Provider.autoDispose<TextEditingController>(
      (ref) => TextEditingController(),
    );

class ProjectListPage extends ConsumerWidget {
  ProjectListPage({super.key});
  bool _initialized = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(projectCodeControllerProvider);

    ref.listen<AsyncValue<UserEntity?>>(userProvider, (prev, next) {
      final user = next.asData?.value;
      print('user : ${user}');
      if (user != null && !_initialized) {
        _initialized = true;
        ref.read(noticeListViewModelProvider.notifier).initialize(user);
        print('user test : ${user}');
      }
    });

    final userAsync = ref.watch(userProvider);
    final noticeListState = ref.watch(noticeListViewModelProvider);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // ✅ 현재 포커스 해제
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: SvgPicture.asset('assets/images/top_app_bar_logo_img.svg'),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: IconButton(
                onPressed: () {
                  log('알림 버튼 클릭');
                },
                icon: CustomIcon(name: 'bell'),
              ),
            ),
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
            return Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  ProjectSearchBar(controller: controller),
                  SizedBox(height: 16),
                  ProjectCardList(projects: noticeListState.projects),
                ],
              ),
            );
          },
        ),

        // ➕ 플로팅 버튼
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            navigateToPage(context, ProjectCreatePage());
          },
          label: Text(
            '프로젝트 추가',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          icon: Icon(Icons.add, color: Colors.white),
          backgroundColor: AppColors.primary500,
        ),
      ),
    );
  }
}
