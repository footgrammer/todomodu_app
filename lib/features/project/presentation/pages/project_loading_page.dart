import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/project/presentation/viewmodels/project_loading_view_model.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project_create/project_loading_progress.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project_create/project_loading_task_text.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project_create/project_loading_text.dart';

class ProjectLoadingPage extends ConsumerWidget {
  const ProjectLoadingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(projectProgressProvider);

    final stepMessages = [
      '당신의 계획을 이해하고 있어요...',
      '할 일을 하나씩 정리 중이에요...',
      '할 일 목록 구성 완료!',
    ];

    // ✅ 상태 변경은 build 이후에 수행
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = ref.read(projectProgressProvider.notifier);
      final progress = ref.watch(projectProgressProvider);

      if (progress.percent == 0.0) {
        controller.resetAndStart();
      }
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF2F1FD), Color(0xFFEDECFD), Color(0xFFE5E3FC)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProjectLoadingProgress(progress: progress),
                  SizedBox(height: 48),
                  ProjectLoadingText(),
                  SizedBox(height: 48),
                  ProjectLoadingTaskText(
                    stepMessages: stepMessages,
                    progress: progress,
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
