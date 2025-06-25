import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todomodu_app/features/project/data/models/project_dto.dart';
import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project/empty_project.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project/project_card.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

class ProjectCardList extends ConsumerWidget {
  List<Project>? projects;

  ProjectCardList({super.key, required this.projects});

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
        : EmptyProject();
  }
}
