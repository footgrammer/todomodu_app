import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/ai/presentation/providers/openai_providers.dart';

class ProjectCreateTestPage extends ConsumerStatefulWidget {
  const ProjectCreateTestPage({super.key});

  @override
  ConsumerState<ProjectCreateTestPage> createState() =>
      _ProjectCreateTestPageState();
}

class _ProjectCreateTestPageState extends ConsumerState<ProjectCreateTestPage> {
  final _formkey = GlobalKey<FormState>();
  final _textEditingController = TextEditingController();

  String? prompt;

  @override
  Widget build(BuildContext context) {
    final responseAsyncValue =
        prompt != null ? ref.watch(openaiResponseProvider(prompt!)) : null;

    return Scaffold(
      appBar: AppBar(title: const Text('프로젝트 생성 테스트')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formkey,
              child: TextFormField(
                controller: _textEditingController,
                decoration: InputDecoration(labelText: '프롬프트 입력'),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  prompt = _textEditingController.text;
                });
              },
              child: const Text('프로젝트 생성'),
            ),
            const SizedBox(height: 32),
            if (responseAsyncValue != null) ...[
              responseAsyncValue.when(
                data: (response) {
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("프로젝트 타이틀: ${response!.projectTitle}"),
                          Text('프로젝트 설명: ${response.projectDescription}'),
                          Text(
                            '프로젝트 기간: ${response.projectStartDate} ~ ${response.projectEndDate}',
                          ),
                          ...List.generate(response.todos.length, (index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '투두${index + 1} 타이틀: ${response.todos[index].todoTitle}',
                                ),
                                Text(
                                  '투두 기간: ${response.todos[index].todoStartDate} ~ ${response.todos[index].todoEndDate}',
                                ),
                                Text(
                                  'subTasks: ${response.todos[index].subTasks}',
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (e, stack) {
                  return Expanded(
                    child: SingleChildScrollView(child: Text("오류: $e, $stack")),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
