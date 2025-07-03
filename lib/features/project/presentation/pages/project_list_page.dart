import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project/project_card.dart';
import 'package:uni_links/uni_links.dart';
import 'package:todomodu_app/features/project/presentation/pages/project_create_page.dart';
import 'package:todomodu_app/features/project/presentation/providers/project_providers.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project/project_card_list.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project/project_search_bar.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';
import 'package:todomodu_app/shared/utils/navigate_to_page.dart';

// 테스트 코드
// xcrun simctl openurl booted "todomodu:///invite?code=12345"

class ProjectListPage extends ConsumerStatefulWidget {
  ProjectListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ProjectListPage> createState() => _ProjectListPageState();
}

class _ProjectListPageState extends ConsumerState<ProjectListPage> {
  StreamSubscription? _sub;
  final projectCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleInitialLink();
      ref.read(projectListViewModelProvider.notifier).fetchProjectsByUserId();
    });
  }

  Future<void> _handleInitialLink() async {
    try {
      final initialUri = await getInitialUri();
      log('getInitialUri 결과: $initialUri');
      if (!mounted) return;
      if (initialUri != null) {
        _processUri(initialUri);
      }
    } catch (e) {
      log('초기 딥링크 처리 실패: $e');
    }
  }

  void _processUri(Uri uri) {
    log('URI 처리 시작: $uri');
    log('pathSegments: ${uri.pathSegments}');
    log('queryParameters: ${uri.queryParameters}');

    if (uri.pathSegments.contains('invite')) {
      final code = uri.queryParameters['code'];
      if (code != null) {
        log('초대코드 수신: $code');
        _runInviteLogic(code);
      } else {
        log('쿼리 파라미터에 code 없음');
      }
    } else {
      log('invite 경로가 아님');
    }
  }

  void _runInviteLogic(String code) async {
    log('초대코드 로직 실행: $code');
    final viewModel = ref.read(projectListViewModelProvider.notifier);

    await viewModel.getProjectByInvitationCode(code.trim());

    final projects = ref.read(projectListViewModelProvider).projects;
    if (projects!.isNotEmpty) {
      final project = projects.first;
      final projectId = project.id;
      log('프로젝트 ID: $projectId');
      final card = ProjectCard(index: 0, project: project);
      card.handleJoinProject(ref, context, project);
    } else {
      log('프로젝트가 없습니다.');
    }
  }

  @override
  void dispose() {
    _sub?.cancel();
    projectCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(projectListViewModelProvider);
    final viewModel = ref.read(projectListViewModelProvider.notifier);
    final hasFetched = ref.watch(hasFetchedProvider);

    if (!hasFetched) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(hasFetchedProvider.notifier).state = true;
        viewModel.fetchProjectsByUserId();
      });
    }

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
                ProjectSearchBar(controller: projectCodeController),
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
