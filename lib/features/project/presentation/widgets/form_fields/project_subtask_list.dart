import 'package:flutter/material.dart';
import 'package:todomodu_app/features/project/presentation/viewmodels/project_create_view_model.dart';

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
                    color: grey50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        subtask,
                        style: subTitle2.copyWith(
                          color: isSelected ? grey800 : grey300,
                        ),
                      ),
                      Icon(
                        isSelected ? Icons.remove : Icons.add,
                        color: isSelected ? grey800 : grey300,
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
