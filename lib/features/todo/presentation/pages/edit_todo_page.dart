import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/todo/presentation/widgets/submit_button.dart';
import 'package:todomodu_app/features/todo/presentation/widgets/todo_date_section.dart';
import 'package:todomodu_app/features/todo/presentation/widgets/todo_title_input.dart';
import 'package:todomodu_app/features/todo/presentation/widgets/subtask/edit_subtask_list.dart';
import 'package:todomodu_app/features/todo/domain/entities/todo.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';
import '../providers/edit_todo_viewmodel_provider.dart';

class EditTodoPage extends ConsumerWidget {
  final Todo todo;
  final List<UserEntity> projectMembers;

  const EditTodoPage({
    super.key,
    required this.todo,
    required this.projectMembers,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(editTodoViewModelProvider(todo));
    final viewModel = ref.watch(editTodoViewModelProvider(todo).notifier);

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
              TodoTitleInput(
                controller: TextEditingController.fromValue(
                  TextEditingValue(
                    text: state.title,
                    selection: TextSelection.collapsed(offset: state.title.length),
                  ),
                ),
                onChanged: viewModel.changeTitle,
              ),
              const SizedBox(height: 24),
              TodoDateSection(
                startDate: state.startDate,
                endDate: state.endDate,
                onStartTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: state.startDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) viewModel.changeStartDate(picked);
                },
                onEndTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: state.endDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) viewModel.changeEndDate(picked);
                },
              ),
              const SizedBox(height: 32),
              Text(
                '할 일 목록',
                style: AppTextStyles.body3.copyWith(color: AppColors.grey500),
              ),
              const SizedBox(height: 8),
              EditSubtaskList(
                todo: todo,
                projectMembers: projectMembers,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SubmitButton(
        label: '수정 완료',
        enabled: viewModel.canSubmit,
        onPressed: () async {
          await viewModel.submit();
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('할 일이 수정되었습니다')),
            );
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
