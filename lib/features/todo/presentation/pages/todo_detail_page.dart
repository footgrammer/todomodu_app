import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/delete_todo_usecase_provider.dart';
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
            onSelected: (value) async {
              if (value == 'delete') {
                await ref.read(deleteTodoUseCaseProvider).call(todo.id);
                if (context.mounted) {
                  Navigator.pop(context);
                }
              }
            },
            itemBuilder: (context) => [
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
                  return ListTile(
                    leading: const Icon(Icons.circle_outlined),
                    title: Text(subTask.title, style: const TextStyle(fontSize: 16)),
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
