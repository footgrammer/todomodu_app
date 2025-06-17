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
      body: Center(
        child: Text('할 일 상세 페이지'),
      ),
    );
  }
}
