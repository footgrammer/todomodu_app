import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todomodu_app/features/project/presentation/viewmodels/project_create_view_model.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';
import 'package:todomodu_app/shared/utils/dialog_utils.dart';

class ProjectTodoList extends StatelessWidget {
  const ProjectTodoList({
    super.key,
    required this.todos,
    required this.selectedTodos,
    required this.viewModel,
  });

  final List todos;
  final Set<String> selectedTodos;
  final ProjectCreateViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children:
          todos.map<Widget>((todo) {
            final title = todo.todoTitle;
            final isSelected = selectedTodos.contains(title);
            log('title : $title');
            return GestureDetector(
              onTap: () {
                if (selectedTodos.length == 1 && isSelected) {
                  DialogUtils.showErrorDialog(
                    context,
                    "최소한 한 개의 할 일은 있어야 합니다.",
                  );
                } else {
                  viewModel.toggleTodo(title);
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : AppColors.grey75,
                  border: Border.all(
                    color:
                        isSelected ? AppColors.primary500 : Colors.transparent,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 4,
                  children: [
                    Icon(
                      Icons.check,
                      size: 24,
                      color:
                          isSelected ? AppColors.primary600 : AppColors.grey300,
                    ),
                    Text(
                      title,
                      style: AppTextStyles.subtitle2.copyWith(
                        color:
                            isSelected
                                ? AppColors.primary600
                                : AppColors.grey300,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
    );
  }
}
