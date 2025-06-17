import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:todomodu_app/features/todo/presentation/providers/add_todo_viewmodel_provider.dart';
import 'package:todomodu_app/features/todo/presentation/widgets/submit_button.dart';
import 'package:todomodu_app/features/todo/presentation/widgets/todo_date_section.dart';
import 'package:todomodu_app/features/todo/presentation/widgets/subtask/subtask_list.dart';
import 'package:todomodu_app/features/todo/presentation/widgets/todo_title_input.dart';

class AddTodoPage extends ConsumerWidget {
  final String projectId;

  const AddTodoPage({super.key, required this.projectId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(addTodoViewModelProvider(projectId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('할 일 추가하기'),
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
                controllers: viewModel.subtaskControllers,
                onRemove: viewModel.removeSubtask,
              ),
              Center(
                child: IconButton(
                  onPressed: viewModel.addSubtask,
                  icon: const Icon(Icons.add_circle_outline, size: 36),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SubmitButton(
        label: '완료',
        onPressed: () async {
          await viewModel.submit();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('할 일이 추가되었습니다')),
          );
          Navigator.pop(context);
        },
      ),
    );
  }
}
