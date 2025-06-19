import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/todo.dart';
import '../../domain/entities/subtask.dart';
import '../providers/subtask_stream_provider.dart';
import '../pages/todo_detail_page.dart';

class TodoCard extends ConsumerWidget {
  final Todo todo;

  const TodoCard({super.key, required this.todo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSubs = ref.watch(subtaskStreamProvider((todo.projectId, todo.id)));

    final dateRange =
        '${todo.startDate.year}.${todo.startDate.month.toString().padLeft(2,'0')}.${todo.startDate.day.toString().padLeft(2,'0')}'
        ' - '
        '${todo.endDate.year}.${todo.endDate.month.toString().padLeft(2,'0')}.${todo.endDate.day.toString().padLeft(2,'0')}';

    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TodoDetailPage(todo: todo))),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(todo.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(dateRange, style: const TextStyle(color: Colors.black54, fontSize: 14)),
          const SizedBox(height: 16),
          asyncSubs.when(
            data: (subs) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: subs.map((s) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(children: [
                    Icon(s.isDone ? Icons.check_circle : Icons.radio_button_unchecked, size: 20, color: s.isDone ? Colors.blue : Colors.grey),
                    const SizedBox(width: 8),
                    Expanded(child: Text(s.title, style: const TextStyle(fontSize: 16))),
                  ]),
                );
              }).toList(),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Text('subtasks 에러: $e'),
          ),
        ]),
      ),
    );
  }
}
