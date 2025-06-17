import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/todo.dart';
import '../providers/edit_todo_viewmodel_provider.dart';
import '../widgets/todo_title_input.dart';
import '../widgets/todo_date_section.dart';
import '../widgets/sub_task/sub_task_list.dart';
import '../widgets/submit_button.dart';

class EditTodoPage extends ConsumerWidget {
  final Todo todo;

  const EditTodoPage({super.key, required this.todo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(editTodoViewModelProvider(todo));

    return Scaffold(
      appBar: AppBar(
        title: const Text('할 일 수정하기'),
        centerTitle: false,
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TodoTitleInput(controller: viewModel.titleController),
              const SizedBox(height: 24),
              TodoDateSection(
                startDate: viewModel.startDate,
                endDate: viewModel.endDate,
                onStartTap: () => viewModel.pickDate(context, true),
                onEndTap: () => viewModel.pickDate(context, false),
              ),
              const SizedBox(height: 24),
              const Text(
                '할 일 목록',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TodoSubTaskList(
                controllers: viewModel.subTaskControllers,
                onRemove: viewModel.removeSubTask,
              ),
              Center(
                child: IconButton(
                  onPressed: viewModel.addSubTask,
                  icon: const Icon(Icons.add_circle_outline, size: 36),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SubmitButton(
        label: '수정 완료',
        onPressed: () async {
          await viewModel.submit();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('할 일이 수정되었습니다')),
          );
          Navigator.pop(context);
        },
      ),
    );
  }
}
