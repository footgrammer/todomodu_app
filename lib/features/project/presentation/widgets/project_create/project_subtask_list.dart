import 'package:flutter/material.dart';
import 'package:todomodu_app/features/project/presentation/models/project_create_state.dart';
import 'package:todomodu_app/features/project/presentation/viewmodels/project_create_view_model.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

class ProjectSubtaskList extends StatelessWidget {
  const ProjectSubtaskList({
    super.key,
    required this.todoToAllSubtasks,
    required this.subtasks,
    required this.state,
    required this.viewModel,
    required this.todo,
  });

  final Map<String, Set<String>> todoToAllSubtasks;
  final Set<String> subtasks;
  final ProjectCreateState state;
  final ProjectCreateViewModel viewModel;
  final String todo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        children:
            (todoToAllSubtasks[todo] ?? {}).map((subtask) {
              final isSelected = subtasks.contains(subtask);

              return GestureDetector(
                onTap: () {
                  final updated = {...subtasks};
                  if (isSelected) {
                    updated.remove(subtask);
                  } else {
                    updated.add(subtask);
                  }

                  final updatedMap = {...state.selectedSubtasks, todo: updated};
                  viewModel.state = state.copyWith(
                    selectedSubtasks: updatedMap,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.grey50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        subtask,
                        style: AppTextStyles.subtitle2.copyWith(
                          color:
                              isSelected
                                  ? AppColors.grey800
                                  : AppColors.grey300,
                        ),
                      ),
                      Icon(
                        isSelected ? Icons.remove : Icons.add,
                        color:
                            isSelected ? AppColors.grey800 : AppColors.grey300,
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
