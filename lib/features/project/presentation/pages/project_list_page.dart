import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app_links/app_links.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project/project_card.dart';
import 'package:todomodu_app/features/project/presentation/pages/project_create_page.dart';
import 'package:todomodu_app/features/project/presentation/providers/project_providers.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project/project_card_list.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project/project_search_bar.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';
import 'package:todomodu_app/shared/utils/navigate_to_page.dart';

class ProjectListPage extends ConsumerStatefulWidget {
  const ProjectListPage({super.key});

  @override
  ConsumerState<ProjectListPage> createState() => _ProjectListPageState();
}

class _ProjectListPageState extends ConsumerState<ProjectListPage> {
  StreamSubscription<Uri>? _sub;
  final projectCodeController = TextEditingController();
  final AppLinks _appLinks = AppLinks(); // app_links 사용

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleInitialLink();
      _listenToIncomingLinks();
      ref.read(projectListViewModelProvider.notifier).fetchProjectsByUserId();
    });
  }

  /// 앱 처음 시작 시 딥링크 처리
  Future<void> _handleInitialLink() async {
    try {
      final initialUri = await _appLinks.getInitialLink();
      log('getInitialAppLink 결과: $initialUri');
      if (!mounted) return;
      if (initialUri != null) {
        _processUri(initialUri);
      }
    } catch (e) {
      log('초기 딥링크 처리 실패: $e');
    }
  }

  /// 앱 실행 중 새 딥링크 수신 처리
  void _listenToIncomingLinks() {
    _sub = _appLinks.uriLinkStream.listen(
      (uri) {
        log('새로운 딥링크 수신: $uri');
        _processUri(uri);
      },
      onError: (err) {
        log('딥링크 수신 중 오류 발생: $err');
      },
    );
  }

  /// URI 분석 및 초대코드 추출
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

  /// 초대 코드 기반 프로젝트 참가 처리
  void _runInviteLogic(String code) async {
    log('초대코드 로직 실행: $code');
    final viewModel = ref.read(projectListViewModelProvider.notifier);

    await viewModel.getProjectByInvitationCode(code.trim());

    final projects = ref.read(projectListViewModelProvider).projects;
    if (projects != null && projects.isNotEmpty) {
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
