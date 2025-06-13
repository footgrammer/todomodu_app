import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/project/presentation/pages/project_create_todo_page.dart';
import 'package:todomodu_app/features/project/presentation/viewmodels/project_loading_view_model.dart';
import 'package:todomodu_app/features/project/presentation/widgets/form_fields/project_loading_progress.dart';
import 'package:todomodu_app/features/project/presentation/widgets/form_fields/project_loading_task_text.dart';
import 'package:todomodu_app/features/project/presentation/widgets/form_fields/project_loading_text.dart';

class ProjectLoadingPage extends ConsumerWidget {
  final Future<Map<String, dynamic>> Function(String) requestChatGPTApi;

  const ProjectLoadingPage({super.key, required this.requestChatGPTApi});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(projectProgressProvider);
    final controller = ref.read(projectProgressProvider.notifier);

    // API 대기 시작 (최초 한 번만 실행)
    ref.listen<ProjectProgressState>(projectProgressProvider, (prev, next) {
      if (next.percent == 0.25) {
        controller.waitForApi<Map<String, dynamic>>(
          () => requestChatGPTApi('haha'),
          (apiResult) async {
            if (context.mounted) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ProjectCreateTodoPage(apiResult: apiResult),
                ),
              );
              await Future.delayed(Duration(seconds: 1));
              controller.reset();
            }
          },
        );
      }
    });

    final stepMessages = [
      '당신의 계획을 이해하고 있어요...',
      '할 일을 하나씩 정리 중이에요...',
      '할 일 목록 구성 완료!',
    ];

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
