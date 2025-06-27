import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/features/project/presentation/providers/project_providers.dart';
import 'package:todomodu_app/features/todo/domain/entities/todo.dart';
import 'package:todomodu_app/features/todo/presentation/providers/subtask/subtask_stream_provider.dart';
import 'package:todomodu_app/features/todo/presentation/providers/todo_stream_provider.dart';
import 'package:todomodu_app/features/todo/presentation/widgets/todo_card/todo_card.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/features/user/presentation/providers/user_providers.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';
import 'package:todomodu_app/shared/widgets/custom_icon.dart';
import 'package:todomodu_app/shared/types/result_extension.dart';

final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

class TodoPage extends ConsumerWidget {
  const TodoPage({super.key});

  bool _isInRange(Todo todo, DateTime date) {
    return (todo.startDate.isBefore(date) || todo.startDate.isAtSameMomentAs(date)) &&
        (todo.endDate.isAfter(date) || todo.endDate.isAtSameMomentAs(date));
  }

  List<DateTime> _getMonthDates(DateTime reference) {
    final firstDay = DateTime(reference.year, reference.month, 1);
    final lastDay = DateTime(reference.year, reference.month + 1, 0);
    return List.generate(lastDay.day, (i) => DateTime(reference.year, reference.month, i + 1));
  }

  String _MonthString(DateTime date) {
    return '${date.month.toString()}월';
  }

  String _weekdayString(DateTime date) {
    const weekdays = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];
    return weekdays[date.weekday % 7];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final userAsync = ref.watch(userProvider);
    final projectUsecase = ref.read(fetchProjectsByUserUsecaseProvider);
    final monthDates = _getMonthDates(selectedDate);

    return userAsync.when(
      data: (user) {
        final uid = user?.userId;

        return FutureBuilder<List<Project>>(
          future: () async {
            final result = await projectUsecase.execute(user!);
            return result.when(
              ok: (projects) => projects,
              error: (e) => throw e,
            );
          }(),
          builder: (context, projSnap) {
            if (!projSnap.hasData) {
              return const Scaffold(body: Center(child: CircularProgressIndicator()));
            }

            final projects = projSnap.data!;

            return Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    SizedBox(width: 8,),
                    SvgPicture.asset('assets/images/top_app_bar_logo_img.svg',),
                                              Text(
            '프로젝트에 참여하거나\n할 일을 할당받아 보세요!',
            textAlign: TextAlign.center,
            style: AppTextStyles.body2.copyWith(color: AppColors.grey500),
          ),
                  ],
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const CustomIcon(name: 'bell'),

                  ),
                  SizedBox(width: 4),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      '${user?.name} 님, 안녕하세요',
                      style: AppTextStyles.body2.copyWith(color: AppColors.grey500),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                             IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: const Icon(Icons.arrow_left, size: 40),
                            onPressed: () {
                              ref.read(selectedDateProvider.notifier).state =
                                  DateTime(selectedDate.year, selectedDate.month - 1, 1);
                            },
                          ),
                          const SizedBox(width: 6),
                          Text(
                            _MonthString(selectedDate),
                            style: AppTextStyles.header1.copyWith(color: AppColors.grey800),
                          ),
                          const SizedBox(width: 6),
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: const Icon(Icons.arrow_right, size: 40),
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
                      child: FutureBuilder<List<Todo>>(
                        future: () async {
                          final todos = <Todo>[];

                          for (final project in projects) {
                            final projectTodos =
                                await ref.read(todoStreamProvider(project.id).future);

                            for (final todo in projectTodos) {
                              if (!_isInRange(todo, selectedDate)) continue;

                              final subtasks = await ref
                                  .read(subtaskStreamProvider((project.id, todo.id)).future);

                              final hasMe = subtasks.any((s) => s.assignee?.userId == uid);
                              if (hasMe) todos.add(todo);
                            }
                          }

                          return todos;
                        }(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(child: CircularProgressIndicator());
                          }

                          final todosToShow = snapshot.data!;
                          if (todosToShow.isEmpty) return _emptyState(context);

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '할 일 ${todosToShow.length}개',
                                style: AppTextStyles.body2.copyWith(color: AppColors.grey500),
                              ),
                              const SizedBox(height: 16),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: todosToShow.length,
                                  itemBuilder: (context, i) => Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: TodoCard(
                                      todo: todosToShow[i],
                                      showProjectTitle: true,
                                      showDateRange: false,
                                      todoTitleTextStyle: AppTextStyles.body3.copyWith(
                                        color: AppColors.grey700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('유저 로딩 에러: $e'))),
    );
  }

  Widget _emptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/images/todo_empty_img.svg', height: 88, width: 62),
          const SizedBox(height: 15),
          Text('아직 등록된 할 일이 없습니다.',
              style: AppTextStyles.body2.copyWith(color: AppColors.grey800)),
          const SizedBox(height: 4),
          Text(
            '프로젝트에 참여하거나\n할 일을 할당받아 보세요!',
            textAlign: TextAlign.center,
            style: AppTextStyles.body2.copyWith(color: AppColors.grey500),
          ),
        ],
      ),
    );
  }
}
