import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/notice/domain/entities/notice.dart';
import 'package:todomodu_app/features/notice/presentation/pages/notice_create_page.dart';
import 'package:todomodu_app/features/notice/presentation/providers/notice_providers.dart';
import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/features/project/presentation/providers/project_providers.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project_detail/project_info_header.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project_detail/project_member_section.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project_detail/project_tab_bar.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/features/user/presentation/pages/main/main_page.dart';
import 'package:todomodu_app/features/user/presentation/providers/user_providers.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';
import 'package:todomodu_app/features/todo/presentation/pages/add_todo_page.dart';
import 'package:todomodu_app/shared/utils/dialog_utils.dart';
import 'package:todomodu_app/shared/utils/navigate_to_page.dart';

part 'project_detail_fab.dart';
part 'project_detail_popup_menu.dart';

class ProjectDetailPage extends ConsumerStatefulWidget {
  final Project project;
  const ProjectDetailPage({super.key, required this.project});

  @override
  ConsumerState<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends ConsumerState<ProjectDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          _currentTabIndex = _tabController.index;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final projectAsync = ref.watch(projectProvider(widget.project.id));

    return projectAsync.when(
      loading:
          () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('프로젝트 로딩 실패: $e'))),
      data: (project) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(''),
            leading: const BackButton(),
            // actions: [buildPopupMenu()],
            actions: [
              Theme(
                data: Theme.of(context).copyWith(
                  popupMenuTheme: PopupMenuThemeData(
                    color: Colors.white, // 전체 팝업 배경
                    textStyle: AppTextStyles.body2.copyWith(
                      color: AppColors.grey800,
                    ),
                  ),
                ),
                child: PopupMenuButton<String>(
                  icon: Icon(Icons.more_vert),
                  onSelected: (value) {
                    if (value == 'leave') {
                      _showLeaveProjectDialog(context, project.id);
                    }
                  },
                  itemBuilder:
                      (context) => [
                        PopupMenuItem(
                          value: 'leave',
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              '프로젝트 삭제하기',
                              style: AppTextStyles.body2.copyWith(
                                color: AppColors.grey800,
                              ),
                            ),
                          ),
                        ),
                      ],
                ),
              ),
            ],
          ),
          body: SafeArea(
            bottom: true,
            minimum: const EdgeInsets.only(bottom: 34),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProjectInfoHeader(project: project),
                      const SizedBox(height: 32),
                      ProjectMemberSection(project: project),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
                Expanded(
                  child: ProjectTabBar(
                    project: widget.project,
                    tabController: _tabController,
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: buildFab(
            tabIndex: _currentTabIndex,
            context: context,
            projectId: widget.project.id,
            projectMembers: project.members,
            ref: ref,
          ),
        );
      },
    );
  }

  void _showLeaveProjectDialog(BuildContext context, String projectId) {
    DialogUtils.showConfirmDialog(
      context,
      '프로젝트를 정말 삭제하시겠습니까?',
      onYes: () async {
        await ref
            .read(deleteProjectUsecaseProvider)
            .execute(projectId: projectId);

        ref.read(projectListViewModelProvider.notifier).fetchProjectsByUserId();
        ref
            .read(noticeListViewModelProvider.notifier)
            .initializeWithoutUserParam();
        replaceAllWithPage(context, MainPage());
      },
    );
  }
}
