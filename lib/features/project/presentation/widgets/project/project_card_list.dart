import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/project/domain/entities/project.dart';
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

  final String titleText;
  final String subText;
  final String image;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return (projects != null && projects!.isNotEmpty)
        ? Expanded(
          child: ListView.separated(
            itemCount: projects == null ? 0 : projects!.length,
            itemBuilder: (context, index) {
              return ProjectCard(index: index, project: projects![index]);
            },
            separatorBuilder: (context, index) => SizedBox(height: 12),
          ),
        )
        : EmptyProject(image: image, title: titleText, subText: subText);
  }
}
