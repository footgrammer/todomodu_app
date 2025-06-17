import 'package:flutter/material.dart';
import 'package:todomodu_app/features/project/presentation/viewmodels/project_create_view_model.dart';

TextStyle header2 = TextStyle(fontSize: 24, fontWeight: FontWeight.w600);
TextStyle subTitle1 = TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
TextStyle subTitle2 = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
TextStyle subTitle3 = TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
Color grey800 = Color(0xFF403F4B);
Color grey500 = Color(0xFF8C8AA0);
Color grey300 = Color(0xFFCAC7DA);
Color grey75 = Color(0xFFF0F0F3);
Color primary600 = Color(0xFF342DE7);
Color primary500 = Color(0xFF5752EA);

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
            final title = todo['todoTitle'] as String;
            final isSelected = selectedTodos.contains(title);

            return GestureDetector(
              onTap: () => viewModel.toggleTodo(title),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : grey75,
                  border: Border.all(
                    color: isSelected ? primary500 : Colors.transparent,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 4,
                  children: [
                    if (isSelected)
                      Icon(Icons.check, size: 24, color: primary600),
                    Text(
                      title,
                      style: subTitle2.copyWith(
                        color: isSelected ? primary600 : grey300,
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
