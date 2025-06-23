import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:todomodu_app/features/project/presentation/pages/project_create_page.dart';
import 'package:todomodu_app/features/todo/domain/entities/todo.dart';
import 'package:todomodu_app/features/todo/presentation/providers/todo_stream_provider.dart';
import 'package:todomodu_app/features/todo/presentation/widgets/todo_card/todo_card.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';
import 'package:todomodu_app/shared/widgets/custom_icon.dart';

final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

class TodoPage extends ConsumerWidget {
  final String projectId;

  const TodoPage({super.key, required this.projectId});

  bool _isInRange(Todo todo, DateTime date) {
    return (todo.startDate.isBefore(date) || todo.startDate.isAtSameMomentAs(date)) &&
        (todo.endDate.isAfter(date) || todo.endDate.isAtSameMomentAs(date));
  }

  List<DateTime> _getMonthDates(DateTime reference) {
    final firstDay = DateTime(reference.year, reference.month, 1);
    final lastDay = DateTime(reference.year, reference.month + 1, 0);
    return List.generate(lastDay.day, (i) => DateTime(reference.year, reference.month, i + 1));
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
    final monthDates = _getMonthDates(selectedDate);

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
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              '사용자 님, 안녕하세요',
              style: AppTextStyles.body2.copyWith(color: AppColors.grey500),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, size: 18),
                  onPressed: () {
                    ref.read(selectedDateProvider.notifier).state =
                        DateTime(selectedDate.year, selectedDate.month - 1, 1);
                  },
                ),
                Text(
                  _yearMonthString(selectedDate),
                  style: AppTextStyles.header1.copyWith(color: AppColors.grey800),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, size: 18),
                  onPressed: () {
                    ref.read(selectedDateProvider.notifier).state =
                        DateTime(selectedDate.year, selectedDate.month + 1, 1);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 56,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: monthDates.length,
                itemBuilder: (context, index) {
                  final date = monthDates[index];
                  final isSelected = date.year == selectedDate.year &&
                      date.month == selectedDate.month &&
                      date.day == selectedDate.day;

                  return GestureDetector(
                    onTap: () => ref.read(selectedDateProvider.notifier).state = date,
                    child: Container(
                      width: 56,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary500 : AppColors.grey75,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _weekdayString(date),
                            style: AppTextStyles.subtitle3.copyWith(
                              color: isSelected ? Colors.white : AppColors.grey400,
                          ),
                          ),
                          Text(
                            date.day.toString(),
                            style: AppTextStyles.subtitle3.copyWith(
                              color: isSelected ? Colors.white : AppColors.grey400,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: todosAsync.when(
                data: (todos) {
                  final filtered = todos.where((t) => _isInRange(t, selectedDate)).toList();

                  return filtered.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/images/todo_empty_img.svg',
                                height: 88,
                                width: 62,
                              ),
                              const SizedBox(height: 15),
                              Text(
                                '아직 등록된 할 일이 없습니다.',
                                style: AppTextStyles.body2.copyWith(
                                  color: AppColors.grey800,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '프로젝트를 생성하여\n오늘의 할 일을 만들어 보세요!',
                                textAlign: TextAlign.center,
                                style: AppTextStyles.body2.copyWith(
                                  color: AppColors.grey500,
                              ),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => const ProjectCreatePage()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  side: BorderSide(color: AppColors.primary600,
                                  width: 1,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),

                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                                ),
                                child: Text('프로젝트 생성하기',
                                style: AppTextStyles.subtitle4.copyWith(
                                  color: AppColors.primary600,
                                ),),
                              ),
                            ],
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '할 일 ${filtered.length}개',
                              style: AppTextStyles.body2.copyWith(
                                color: AppColors.grey500,
                              )
                            ),
                            const SizedBox(height: 16),
                            Expanded(
                              child: ListView.builder(
                                padding: const EdgeInsets.only(bottom: 64),
                                itemCount: filtered.length,
                                itemBuilder: (context, i) => TodoCard(
                                  todo: filtered[i],
                                  showProjectTitle: true,
                                  showDateRange: false,
                                  todoTitleTextStyle: AppTextStyles.body3.copyWith(
                                    color: AppColors.grey700,
                                  ),),
                              ),
                            ),
                          ],
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