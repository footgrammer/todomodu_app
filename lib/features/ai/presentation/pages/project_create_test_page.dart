import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/ai/domain/models/openai_params.dart';
import 'package:todomodu_app/features/ai/presentation/providers/openai_providers.dart';

class ProjectCreateTestPage extends ConsumerStatefulWidget {
  const ProjectCreateTestPage({super.key});

  @override
  ConsumerState<ProjectCreateTestPage> createState() =>
      _ProjectCreateTestPageState();
}

class _ProjectCreateTestPageState extends ConsumerState<ProjectCreateTestPage> {
  final _formkey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _starDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _promptController = TextEditingController();

  OpenaiParams? openaiParams;

  @override
  Widget build(BuildContext context) {
    final responseAsyncValue =
        openaiParams != null
            ? ref.watch(openaiResponseProvider(openaiParams!))
            : null;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('프로젝트 생성 테스트')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: '프로젝트 타이틀 입력'),
                ),
                TextFormField(
                  controller: _starDateController,
                  decoration: InputDecoration(labelText: '프로젝트 시작 날짜 입력'),
                ),
                TextFormField(
                  controller: _endDateController,
                  decoration: InputDecoration(labelText: '프로젝트 종료 날짜 입력'),
                ),
                TextFormField(
                  controller: _promptController,
                  decoration: InputDecoration(labelText: '프롬프트 입력'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      openaiParams = OpenaiParams(
                        projectTitle: _titleController.text,
                        projectStartDate: DateTime.parse(
                          _starDateController.text,
                        ),
                        projectEndDate: DateTime.parse(_endDateController.text),
                        prompt: _promptController.text,
                      );
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
                        child: SingleChildScrollView(
                          child: Text("오류: $e, $stack"),
                        ),
                      );
                    },
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
