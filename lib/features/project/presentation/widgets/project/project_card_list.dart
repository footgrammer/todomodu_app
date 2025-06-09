import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/project/data/models/Project.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project/project_card.dart';

class ProjectCardList extends ConsumerWidget {
  List<Project>? projects;

  ProjectCardList({super.key, required this.projects});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: ListView.builder(
        itemCount: projects == null ? 0 : projects!.length,
        itemBuilder: (context, index) {
          return ProjectCard(index: index, project: projects![index]);
        },
      ),
    );
  }
}
