import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/todo/domain/entities/todo.dart';
import 'package:todomodu_app/features/todo/presentation/providers/todo_stream_provider.dart';
import 'package:todomodu_app/features/todo/presentation/widgets/todo_card.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TodoPage extends ConsumerWidget {
  final String projectId;

  const TodoPage({super.key, required this.projectId});

  bool _isTodayInRange(Todo todo) {
    final now = DateTime.now();
    return (todo.startDate.isBefore(now) || todo.startDate.isAtSameMomentAs(now)) &&
           (todo.endDate.isAfter(now) || todo.endDate.isAtSameMomentAs(now));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTodos = ref.watch(todoStreamProvider(projectId));

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SvgPicture.asset('assets/images/top_app_bar_logo_img.svg', height: 28),
            const SizedBox(width: 8),
            const Text('tdmd.'),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none),
          )
        ],
      ),
      body: asyncTodos.when(
        data: (todos) {
          final todayTodos = todos.where(_isTodayInRange).toList();
          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 64),
            itemCount: todayTodos.length,
            itemBuilder: (context, i) => TodoCard(todo: todayTodos[i]),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('에러: $e')),
      ),
    );
  }
}
