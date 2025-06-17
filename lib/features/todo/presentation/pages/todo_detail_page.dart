import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/delete_todo_usecase_provider.dart';
import '../providers/toggle_subtask_done_usecase_provider.dart';
import '../../domain/entities/todo.dart';

class TodoDetailPage extends ConsumerWidget {
  final Todo todo;

  const TodoDetailPage({super.key, required this.todo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
appBar: AppBar(
  title: Text(todo.title),
  actions: [
    PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      onSelected: (value) async {
        if (value == 'edit') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditTodoPage(todo: todo),
            ),
          );
        } else if (value == 'delete') {
          await ref.read(deleteTodoUseCaseProvider).call(todo.id);
          if (context.mounted) {
            Navigator.pop(context);
          }
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(value: 'edit', child: Text('할 일 수정하기')),
        const PopupMenuItem(value: 'delete', child: Text('할 일 삭제하기')),
      ],
    ),
  ],
),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('시작일: ${formatDate(todo.startDate)}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('종료일: ${formatDate(todo.endDate)}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 24),
            const Text('세부 할 일', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: todo.subTasks.length,
                itemBuilder: (context, index) {
                  final subTask = todo.subTasks[index];
                  return CheckboxListTile(
                    value: subTask.isDone,
                    onChanged: (value) async {
                      await ref.read(toggleSubTaskDoneUseCaseProvider).call(
                        todoId: todo.id,
                        subTaskId: subTask.id,
                        isDone: value ?? false,
                      );
                    },
                    title: Text(
                      subTask.title,
                      style: TextStyle(
                        fontSize: 16,
                        decoration: subTask.isDone ? TextDecoration.lineThrough : TextDecoration.none,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatDate(DateTime date) {
    return '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';
  }
}
