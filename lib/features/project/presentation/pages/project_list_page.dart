import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uni_links/uni_links.dart';
import 'package:todomodu_app/features/project/presentation/pages/project_create_page.dart';
import 'package:todomodu_app/features/project/presentation/providers/project_providers.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project/project_card_list.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project/project_search_bar.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';
import 'package:todomodu_app/shared/utils/navigate_to_page.dart';

final projectCodeControllerProvider =
    Provider.autoDispose<TextEditingController>(
  (ref) => TextEditingController(),
);

final inviteCodeProvider = StateProvider<String?>((ref) => null);

class ProjectListPage extends ConsumerStatefulWidget {
  ProjectListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ProjectListPage> createState() => _ProjectListPageState();
}

class _ProjectListPageState extends ConsumerState<ProjectListPage> {
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    _handleInitialLink();
    _sub = uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        _processUri(uri);
      }
    }, onError: (error) {
      log('딥링크 처리 중 오류 발생: $error');
    });
  }

  Future<void> _handleInitialLink() async {
    try {
      final initialUri = await getInitialUri();
      if (initialUri != null) {
        _processUri(initialUri);
      }
    } on Exception catch (e) {
      log('초기 딥링크 처리 실패: $e');
    }
  }

  void _processUri(Uri uri) {
    if (uri.pathSegments.contains('invite')) {
      final code = uri.queryParameters['code'];
      if (code != null) {
        log('초대코드 수신: $code');
        ref.read(inviteCodeProvider.notifier).state = code;
        _runInviteLogic(code);
      }
    }
  }

  void _runInviteLogic(String code) {
    // TODO: 서버 호출, UI 업데이트 등 원하는 로직 구현
    log('초대코드 로직 실행: $code');
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(projectListViewModelProvider);
    final viewModel = ref.read(projectListViewModelProvider.notifier);
    final inviteCode = ref.watch(inviteCodeProvider);

    final hasFetched = ref.watch(hasFetchedProvider);
    if (!hasFetched) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(hasFetchedProvider.notifier).state = true;
        viewModel.fetchProjectsByUserId();

        if (inviteCode != null) {
          log('초대코드 활용 시점: $inviteCode');
          // 필요시 초대코드로 프로젝트 참가 요청 등 추가 로직 작성
        }
      });
    }

    final controller = ref.watch(projectCodeControllerProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: SvgPicture.asset('assets/images/top_app_bar_logo_img.svg'),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: RefreshIndicator(
            onRefresh: () async {
              await viewModel.fetchProjectsByUserId();
            },
            child: Column(
              children: [
                if (inviteCode != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      '초대코드 받음: $inviteCode',
                      style: const TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  ),
                ProjectSearchBar(controller: controller),
                const SizedBox(height: 16),
                ProjectCardList(projects: state.projects),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            navigateToPage(context, ProjectCreatePage());
          },
          label: const Text(
            '프로젝트 추가',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          icon: const Icon(Icons.add, color: Colors.white),
          backgroundColor: AppColors.primary500,
        ),
      ),
    );
  }
}
