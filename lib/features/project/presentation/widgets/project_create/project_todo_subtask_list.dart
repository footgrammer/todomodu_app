import 'package:flutter/material.dart';
import 'package:todomodu_app/features/project/presentation/models/project_create_state.dart';
import 'package:todomodu_app/features/project/presentation/viewmodels/project_create_view_model.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project_create/project_subtask_list.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

class ProjectTodoSubtaskList extends StatelessWidget {
  const ProjectTodoSubtaskList({
    super.key,
    required this.selectedTodos,
    required this.projectCreateState,
    required this.todoToAllSubtasks,
    required this.viewModel,
    required this.onTap,
  });

  final Set<String> selectedTodos;
  final ProjectCreateState projectCreateState;
  final Map<String, Set<String>> todoToAllSubtasks;
  final ProjectCreateViewModel viewModel;
  final void Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children:
            selectedTodos.map((todo) {
              final isExpanded =
                  projectCreateState.expandedItems == null
                      ? false
                      : projectCreateState.expandedItems!.contains(todo);
              final subtasks =
                  projectCreateState.selectedSubtasks[todo] ?? <String>{};

              return GestureDetector(
                onTap: () {
                  onTap(todo);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.grey200),
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.grey50,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(todo, style: AppTextStyles.subtitle1),
                          Icon(
                            isExpanded ? Icons.expand_less : Icons.expand_more,
                            size: 24,
                          ),
                        ],
                      ),
                      if (isExpanded) SizedBox(height: 12),
                      if (isExpanded)
                        ProjectSubtaskList(
                          todoToAllSubtasks: todoToAllSubtasks,
                          subtasks: subtasks,
                          todo: todo,
                          onTap: (String subtask) {
                            final isSelected = subtasks.contains(subtask);
                            final updated = {...subtasks};
                            if (isSelected) {
                              updated.remove(subtask);
                            } else {
                              updated.add(subtask);
                            }
                            viewModel.updateSelectedSubtasks(todo, updated);
                          },
                        ),
                    ],
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
