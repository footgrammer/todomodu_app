import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/project/presentation/models/project_create_state.dart';
import 'package:todomodu_app/features/project/presentation/viewmodels/project_create_view_model.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project_create/project_subtask_list.dart';

TextStyle header2 = TextStyle(fontSize: 24, fontWeight: FontWeight.w600);
TextStyle subTitle1 = TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
TextStyle subTitle2 = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
TextStyle subTitle3 = TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
Color grey900 = Color(0xFF28282F);
Color grey800 = Color(0xFF403F4B);
Color grey500 = Color(0xFF8C8AA0);
Color grey300 = Color(0xFFCAC7DA);
Color grey200 = Color(0xFFDCDBE4);
Color grey75 = Color(0xFFF0F0F3);
Color grey50 = Color(0xFFF7F7F8);
Color primary600 = Color(0xFF342DE7);
Color primary500 = Color(0xFF5752EA);

class ProjectTodoSubtaskList extends StatelessWidget {
  const ProjectTodoSubtaskList({
    super.key,
    required this.selectedTodos,
    required this.state,
    required this.todoToAllSubtasks,
    required this.viewModel,
    required this.ref,
  });

  final Set<String> selectedTodos;
  final ProjectCreateState state;
  final Map<String, Set<String>> todoToAllSubtasks;
  final ProjectCreateViewModel viewModel;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children:
            selectedTodos.map((todo) {
              final isExpanded =
                  state.expandedItems == null
                      ? false
                      : state.expandedItems!.contains(todo);
              final subtasks = state.selectedSubtasks[todo] ?? <String>{};

              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: grey200),
                  borderRadius: BorderRadius.circular(12),
                  color: grey50,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                margin: const EdgeInsets.only(bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        ref
                            .read(projectCreateViewModelProvider.notifier)
                            .toggleExpandedItems(todo);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(todo, style: subTitle1),
                          Icon(
                            isExpanded ? Icons.expand_less : Icons.expand_more,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                    if (isExpanded) SizedBox(height: 12),
                    if (isExpanded)
                      ProjectSubtaskList(
                        todoToAllSubtasks: todoToAllSubtasks,
                        subtasks: subtasks,
                        state: state,
                        viewModel: viewModel,
                        todo: todo,
                      ),
                  ],
                ),
              );
            }).toList(),
      ),
    );
  }
}
