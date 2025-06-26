import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/project/presentation/providers/project_providers.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project/project_card_list.dart';

class ClosedProjectListPage extends ConsumerWidget {
  const ClosedProjectListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(projectListViewModelProvider);
    final viewModel = ref.read(projectListViewModelProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          '종료된 프로젝트',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: RefreshIndicator(
          onRefresh: () async {
            await viewModel.fetchProjectsByUserId();
          },
          child: IgnorePointer(
            child: Center(
              child: Column(
                // ProjectCardList가 Expanded로 감싸져있어 Column 추가했습니다
                children: [
                  ProjectCardList(
                    projects:
                        state.projects!
                            .where((project) => project.isDone == true)
                            .toList(),
                    titleText: '아직 종료된 프로젝트가 없습니다.',
                    subText: '프로젝트를 완료하고\n목록에서 확인해보세요!',
                    image: 'assets/images/closed_project_empty_img.svg',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
