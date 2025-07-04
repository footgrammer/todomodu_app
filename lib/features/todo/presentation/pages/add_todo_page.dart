import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/todo/presentation/providers/add_todo_viewmodel_provider.dart';
import 'package:todomodu_app/features/todo/presentation/widgets/submit_button.dart';
import 'package:todomodu_app/features/todo/presentation/widgets/todo_date_section.dart';
import 'package:todomodu_app/features/todo/presentation/widgets/todo_title_input.dart';
import 'package:todomodu_app/features/todo/presentation/widgets/subtask/add_subtask_list.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

class AddTodoPage extends ConsumerWidget {
  final String projectId;
  final List<UserEntity> projectMembers;

  const AddTodoPage({
    super.key,
    required this.projectId,
    required this.projectMembers,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(addTodoViewModelProvider(projectId));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '할 일 추가하기',
          style: AppTextStyles.header3.copyWith(color: AppColors.grey800),
        ),
        centerTitle: false,
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TodoTitleInput(controller: viewModel.titleController),
              const SizedBox(height: 32),
              TodoDateSection(
                startDate: viewModel.startDate,
                endDate: viewModel.endDate,
                onStartTap: () => viewModel.pickDate(context, true),
                onEndTap: () => viewModel.pickDate(context, false),
              ),
              const SizedBox(height: 32),
              Text(
                '할 일 목록',
                style: AppTextStyles.body3.copyWith(color: AppColors.grey500),
              ),
              const SizedBox(height: 8),
              AddSubtaskList(
                projectId: projectId,
                todoId: viewModel.pendingTodoId,
                projectMembers: projectMembers,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SubmitButton(
        label: '추가하기',
        enabled: viewModel.canSubmit,
        onPressed: () async {
          await viewModel.submitWithSubtasks();
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('할 일이 추가되었습니다')),
            );
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
