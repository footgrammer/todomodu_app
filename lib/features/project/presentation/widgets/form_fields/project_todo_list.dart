import 'package:flutter/widgets.dart';
import 'package:todomodu_app/features/project/presentation/viewmodels/project_create_view_model.dart';

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
