import 'package:flutter/material.dart';
import 'package:todomodu_app/features/todo/presentation/pages/todo_detail_page.dart';
import '../../domain/entities/todo.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;

  const TodoCard({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final dateRange =
        '${todo.startDate.year}.${todo.startDate.month.toString().padLeft(2, '0')}.${todo.startDate.day.toString().padLeft(2, '0')}'
        ' - '
        '${todo.endDate.year}.${todo.endDate.month.toString().padLeft(2, '0')}.${todo.endDate.day.toString().padLeft(2, '0')}';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => TodoDetailPage(todo: todo)),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              todo.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              dateRange,
              style: const TextStyle(color: Colors.black54, fontSize: 14),
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: todo.subtasks.map((subTask) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle_outline, size: 20, color: Colors.grey),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          subTask.title,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
