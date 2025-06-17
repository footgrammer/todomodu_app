import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/todo.dart';
import '../providers/edit_todo_viewmodel_provider.dart';
import '../widgets/todo_date_section.dart';
import '../widgets/submit_button.dart';

class EditTodoPage extends ConsumerWidget {
  final Todo todo;

  const EditTodoPage({super.key, required this.todo});

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
              TextField(
                decoration: const InputDecoration(labelText: '제목'),
                controller: TextEditingController.fromValue(
                  TextEditingValue(
                    text: state.title,
                    selection: TextSelection.collapsed(
                      offset: state.title.length,
                    ),
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
                  if (picked != null) {
                    viewModel.changeStartDate(picked);
                  }
                },
                onEndTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: state.endDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    viewModel.changeEndDate(picked);
                  }
                },
              ),
              const SizedBox(height: 24),
              const Text(
                '할 일 목록',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              ...state.subtasks.asMap().entries.map((entry) {
                final index = entry.key;
                final subtask = entry.value;

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: '세부 할 일',
                          ),
                          controller: TextEditingController.fromValue(
                            TextEditingValue(
                              text: subtask.title,
                              selection: TextSelection.collapsed(
                                offset: subtask.title.length,
                              ),
                            ),
                          ),
                          onChanged:
                              (value) =>
                                  viewModel.changeSubtaskTitle(index, value),
                        ),
                      ),
                      IconButton(
                        onPressed: () => viewModel.removeSubtask(index),
                        icon: const Icon(
                          Icons.remove_circle_outline,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                );
              }),

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
        label: '수정 완료',
        onPressed: () async {
          await viewModel.submit();
          if (context.mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('할 일이 수정되었습니다')));
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
