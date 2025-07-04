import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/project/presentation/providers/project_title_provider.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

class ProjectTitleChip extends ConsumerWidget {
  final String projectId;

  const ProjectTitleChip({super.key, required this.projectId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleAsync = ref.watch(projectTitleProvider(projectId));

    return titleAsync.when(
      data: (title) => Text(
        title,
        style: AppTextStyles.body1.copyWith(
          color: AppColors.grey800,
        ),
      ),
      loading: () => const SizedBox(
        height: 16,
        width: 16,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
      error: (_, __) => const Text('에러', style: TextStyle(color: Colors.red)),
    );
  }
}