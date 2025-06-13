import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/todo/domain/entities/sub_task.dart';
import 'package:todomodu_app/features/todo/domain/entities/todo.dart';
import 'package:todomodu_app/features/todo/presentation/providers/add_todo_viemodel_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:todomodu_app/features/todo/application/usecases/create_todo_usecase.dart';
import 'package:todomodu_app/features/todo/presentation/widgets/date_picker_box.dart';
import 'package:todomodu_app/features/todo/presentation/widgets/submit_button.dart';
import 'package:todomodu_app/features/todo/presentation/widgets/todo_date_section.dart';
import 'package:todomodu_app/features/todo/presentation/widgets/sub_task/sub_task_list.dart';
import 'package:todomodu_app/features/todo/presentation/widgets/todo_title_input.dart';

class AddTodoPage extends ConsumerWidget {
  const AddTodoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(addTodoViewModelProvider);

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
        label: '완료',
        onPressed: () async {
          await viewModel.submit();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('할 일이 추가되었습니다')));
          Navigator.pop(context);
        },
      ),
    );
  }
}
