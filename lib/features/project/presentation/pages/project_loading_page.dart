import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/project/presentation/pages/project_create_todo_page.dart';
import 'package:todomodu_app/features/project/presentation/viewmodels/project_loading_view_model.dart';

class ProjectLoadingPage extends ConsumerWidget {
  final Future<void> requestChatGPTApi;

  const ProjectLoadingPage({super.key, required this.requestChatGPTApi});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(projectProgressProvider);
    final controller = ref.read(projectProgressProvider.notifier);

    // API 대기 시작 (최초 한 번만 실행)
    ref.listen<ProjectProgressState>(projectProgressProvider, (prev, next) {
      if (next.percent == 0.25) {
        controller.waitForApi(requestChatGPTApi, () {
          if (context.mounted) {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => ProjectCreateTodoPage()));
          }
        });
      }
    });

    final stepMessages = [
      '당신의 계획을 이해하고 있어요...',
      '할 일을 하나씩 정리 중이에요...',
      '할 일 목록 구성 완료!',
    ];

    return Scaffold(
      appBar: AppBar(),
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
                  SizedBox(
                    width: 180,
                    height: 180,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox.expand(
                          child: CircularProgressIndicator(
                            value: progress.percent,
                            strokeWidth: 8,
                            valueColor: AlwaysStoppedAnimation(
                              Color(0xFF5752EA),
                            ),
                            backgroundColor: Colors.grey.shade300,
                          ),
                        ),
                        Text(
                          '${(progress.percent * 100).round()}%',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 48),

                  Text(
                    '할 일 목록 생성 중...',
                    style: TextStyle(
                      color: Color(0xFF403F4B),
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '프로젝트에 딱 맞는 할 일을 찾고 있어요',
                    style: TextStyle(
                      color: Color(0xFF8C8AA0),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 48),
                  Column(
                    children: List.generate(stepMessages.length, (i) {
                      final active = i <= progress.stepIndex;
                      final icon =
                          active
                              ? Icon(
                                Icons.check_circle,
                                color: Color(0xFF5752EA),
                              )
                              : Icon(
                                Icons.radio_button_unchecked,
                                color: Colors.grey,
                              );
                      return Container(
                        height: 64,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            icon,
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                stepMessages[i],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                      active
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                  color:
                                      active ? Color(0xFF403F4B) : Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
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
