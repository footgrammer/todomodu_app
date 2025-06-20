import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todomodu_app/features/project/presentation/pages/project_create_page.dart';
import 'package:todomodu_app/features/todo/domain/entities/todo.dart';
import 'package:todomodu_app/features/todo/presentation/providers/todo_stream_provider.dart';
import 'package:todomodu_app/features/todo/presentation/widgets/todo_card/todo_card.dart';
import 'package:todomodu_app/shared/widgets/custom_icon.dart';

final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

class TodoPage extends ConsumerWidget {
  final String projectId;

  const TodoPage({super.key, required this.projectId});

  bool _isInRange(Todo todo, DateTime date) {
    return (todo.startDate.isBefore(date) || todo.startDate.isAtSameMomentAs(date)) &&
        (todo.endDate.isAfter(date) || todo.endDate.isAtSameMomentAs(date));
  }

  List<DateTime> _getWeekDates(DateTime reference) {
    final startOfWeek = reference.subtract(Duration(days: reference.weekday % 7));
    return List.generate(7, (i) => startOfWeek.add(Duration(days: i)));
  }

  String _yearMonthString(DateTime date) {
    return '${date.year}년 ${date.month.toString().padLeft(2, '0')}월';
  }

  String _weekdayString(DateTime date) {
    const weekdays = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];
    return weekdays[date.weekday % 7];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosAsync = ref.watch(todoStreamProvider(projectId));
    final selectedDate = ref.watch(selectedDateProvider);
    final weekDates = _getWeekDates(selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SvgPicture.asset('assets/images/top_app_bar_logo_img.svg', height: 20),
            const SizedBox(width: 8),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const CustomIcon(name: 'bell'),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              _yearMonthString(selectedDate),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: weekDates.map((date) {
                final isSelected = date.year == selectedDate.year &&
                    date.month == selectedDate.month &&
                    date.day == selectedDate.day;
                return GestureDetector(
                  onTap: () => ref.read(selectedDateProvider.notifier).state = date,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF706FBF) : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Text(
                          _weekdayString(date),
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          date.day.toString(),
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black87,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: todosAsync.when(
                data: (todos) {
                  final filtered = todos
                      .where((t) => _isInRange(t, selectedDate))
                      .toList();

                  return filtered.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/images/todo_empty_img.svg',
                                height: 160,
                              ),
                              const SizedBox(height: 24),
                              const Text(
                                '아직 등록된 할 일이 없습니다.',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                '프로젝트를 생성하여\n오늘의 할 일을 만들어 보세요!',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.black54),
                              ),
                              const SizedBox(height: 24),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => const ProjectCreatePage()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: const Color(0xFF706FBF),
                                  backgroundColor: Colors.white,
                                  side: const BorderSide(color: Color(0xFF706FBF)),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                ),
                                child: const Text('프로젝트 생성하기'),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.only(bottom: 64),
                          itemCount: filtered.length,
                          itemBuilder: (context, i) => TodoCard(todo: filtered[i]),
                        );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('에러 발생: $e')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
