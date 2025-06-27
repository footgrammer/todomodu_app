import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/features/project/presentation/providers/project_providers.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project/empty_project.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project/project_card.dart';

class ProjectCardList extends ConsumerWidget {
  List<Project>? projects;

  ProjectCardList({
    super.key,
    required this.projects,
    this.titleText = '아직 등록된 프로젝트가 없습니다.',
    this.subText = '프로젝트를 완료하고\n목록에서 확인해보세요!',
    this.image = 'assets/images/project_list_empty_img.svg',
  });

  String titleText;
  String subText;
  final String image;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(projectListViewModelProvider);
    if (state.fetchType == 'myProjects') {
      titleText = '아직 등록된 프로젝트가 없습니다.';
      subText = '프로젝트를 완료하고\n목록에서 확인해보세요!';
    } else {
      titleText = '프로젝트 코드에 맞는 프로젝트가 없습니다.';
      subText = '프로젝트 코드를 다시 입력해 주세요!';
    }
    return (projects != null && projects!.isNotEmpty)
        ? Expanded(
          child: ListView.separated(
            itemCount: projects == null ? 0 : projects!.length + 1,
            itemBuilder: (context, index) {
              if (index == projects!.length) {
                return const SizedBox(height: 44); // 👈 마지막 여백
              }
              return ProjectCard(index: index, project: projects![index]);
            },
            separatorBuilder: (context, index) => SizedBox(height: 12),
          ),
        )
        : EmptyProject(image: image, title: titleText, subText: subText);
  }
}
