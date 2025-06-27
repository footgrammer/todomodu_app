import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/notice/domain/entities/notice.dart';
import 'package:todomodu_app/features/notice/presentation/pages/notice_create_page.dart';
import 'package:todomodu_app/features/notice/presentation/providers/notice_providers.dart';
import 'package:todomodu_app/features/project/presentation/providers/project_providers.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project_detail/project_info_header.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project_detail/project_member_section.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project_detail/project_tab_bar.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/features/user/presentation/providers/user_providers.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';
import 'package:todomodu_app/features/todo/presentation/pages/add_todo_page.dart';

part 'project_detail_fab.dart';
part 'project_detail_popup_menu.dart';

class ProjectDetailPage extends ConsumerStatefulWidget {
  final String projectId;
  const ProjectDetailPage({super.key, required this.projectId});

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
    final projectAsync = ref.watch(projectProvider(widget.projectId));

    return projectAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('프로젝트 로딩 실패: $e'))),
      data: (project) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(''),
            leading: const BackButton(),
            actions: [buildPopupMenu()],
          ),
          body: SafeArea(
            bottom: true,
            minimum: const EdgeInsets.only(bottom: 34),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProjectInfoHeader(project: project),
                      const SizedBox(height: 32),
                      ProjectMemberSection(members: project.members),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
                Expanded(
                  child: ProjectTabBar(
                    projectId: widget.projectId,
                    tabController: _tabController,
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: buildFab(
            tabIndex: _currentTabIndex,
            context: context,
            projectId: widget.projectId,
            projectMembers: project.members,
            ref : ref,
          ),
        );
      },
    );
  }
}
