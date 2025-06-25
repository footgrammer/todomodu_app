import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todomodu_app/features/project/presentation/providers/project_providers.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project_detail/project_info_header.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project_detail/project_member_section.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project_detail/project_tab_bar.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

class ProjectDetailPage extends ConsumerWidget {
  final String projectId;

  const ProjectDetailPage({super.key, required this.projectId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectAsync = ref.watch(projectProvider(projectId));

    return projectAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('프로젝트 로딩 실패: $e'))),
      data: (project) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('프로젝트 상세'),
              leading: const BackButton(),
              actions: [_popupMenu()],
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
                        const SizedBox(height: 28),
                      ],
                    ),
                  ),
                  Expanded(child: ProjectTabBar(projectId: projectId)),
                ],
              ),
            ),
            floatingActionButton: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: SizedBox(
                height: 48,
                width: 129,
                child: FloatingActionButton.extended(
                  heroTag: 'uniqueTagForThisPage',
                  backgroundColor: AppColors.primary500,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                  onPressed: () {
                    Navigator.pushNamed(context, '/add-todo', arguments: projectId);
                  },
                  icon: const Icon(Icons.add),
                  label: Text('할 일 추가', style: AppTextStyles.subtitle1),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _popupMenu() {
    return Row(
      children: [
        PopupMenuButton<String>(
          menuPadding: const EdgeInsets.symmetric(horizontal: 9),
          icon: const Icon(Icons.more_vert),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          offset: const Offset(-10, 40),
          color: Colors.white,
          onSelected: (value) {
            if (value == 'edit') {
              // 프로젝트 수정
            } else if (value == 'leave') {
              // 프로젝트 나가기
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'edit',
              padding: EdgeInsets.zero,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('프로젝트 정보 수정하기', style: AppTextStyles.body2.copyWith(color: AppColors.grey800)),
              ),
            ),
            PopupMenuItem(
              value: 'leave',
              padding: EdgeInsets.zero,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('프로젝트 나가기', style: AppTextStyles.body2.copyWith(color: AppColors.grey800)),
              ),
            ),
          ],
        ),
        const SizedBox(width: 14),
      ],
    );
  }
}
