import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project_detail/project_tab_bar.dart';
import 'package:todomodu_app/features/todo/domain/entities/todo.dart';
import 'package:todomodu_app/features/todo/presentation/pages/add_todo_page.dart';
import 'package:todomodu_app/features/todo/presentation/providers/todo_list_viewmodel_provider.dart';
import 'package:todomodu_app/features/todo/presentation/widgets/todo_card/todo_card.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

class ProjectDetailPage extends ConsumerWidget {
  final String projectId;

  const ProjectDetailPage({super.key, required this.projectId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(todoListViewModelProvider);
    final todosStream = viewModel.todosStream(projectId);

    // 더미
    final projectTitle = '프로젝트 2';
    final startDate = DateFormat('yyyy.MM.dd').format(DateTime(2025, 6, 18));
    final endDate = DateFormat('yyyy.MM.dd').format(DateTime(2025, 7, 10));
    final progress = 0.6;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('프로젝트 상세'),
          leading: const BackButton(),
          actions: [
            PopupMenuButton<String>(
              menuPadding: const EdgeInsets.symmetric(horizontal: 9),
              icon: const Icon(Icons.more_vert),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              offset: const Offset(-10, 40),
              color: Colors.white,
              onSelected: (value) {
                switch (value) {
                  case 'edit':
                    //  수정 페이지 이동
                    break;
                  case 'leave':
                    //  나가기 로직
                    break;
                }
              },
              itemBuilder:
                  (context) => [
                    PopupMenuItem(
                      value: 'edit',
                      padding: EdgeInsets.zero,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('프로젝트 정보 수정하기',
                        style: AppTextStyles.body2.copyWith(color: AppColors.grey800),),
                      ),
                    ),
                    PopupMenuItem(
                      value: 'leave',
                      padding: EdgeInsets.zero,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('프로젝트 나가기',
                        style: AppTextStyles.body2.copyWith(color: AppColors.grey800)),
                      ),
                    ),
                  ],
            ),
            const SizedBox(width: 14),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            bottom: 34.0,
            top: 8,
            right: 24,
            left: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 프로젝트 제목
              Text(
                projectTitle,
                style: AppTextStyles.header2.copyWith(color: AppColors.grey800),
              ),

              const SizedBox(height: 32),

              // 날짜 및 진척도
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '시작일',
                        style: AppTextStyles.subtitle3.copyWith(
                          color: AppColors.grey500,
                        ),
                      ),
                      Text(
                        startDate,
                        style: AppTextStyles.body2.copyWith(
                          color: AppColors.grey800,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '종료일',
                        style: AppTextStyles.subtitle3.copyWith(
                          color: AppColors.grey500,
                        ),
                      ),
                      Text(
                        endDate,
                        style: AppTextStyles.body2.copyWith(
                          color: AppColors.grey800,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '진척도',
                        style: AppTextStyles.subtitle3.copyWith(
                          color: AppColors.grey500,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '${(progress * 100)}%',
                            style: AppTextStyles.body2.copyWith(
                              color: AppColors.grey800,
                            ),
                          ),
                          const SizedBox(width: 7),
                          SizedBox(
                            width: 56,
                            height: 8,
                            child: LinearProgressIndicator(
                              value: progress,
                              backgroundColor: AppColors.grey200,
                              color: AppColors.primary500,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // 팀원 섹션
              Text(
                '팀원',
                style: AppTextStyles.subtitle1.copyWith(
                  color: AppColors.grey800,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  CircleAvatar(radius: 16, backgroundColor: Colors.orange[400]),
                  const Spacer(),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.add, color: AppColors.primary600),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.primary50,
                      side: BorderSide(color: AppColors.primary600),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      padding: const EdgeInsets.all(10),
                    ),
                    label: Text(
                      '팀원 초대',
                      style: AppTextStyles.subtitle3.copyWith(
                        color: AppColors.primary600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              const ProjectTabBar(),

              Expanded(
                child: StreamBuilder<List<Todo>>(
                  stream: todosStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('에러 발생: ${snapshot.error}'));
                    }

                    final todos = snapshot.data ?? [];
                    if (todos.isEmpty) {
                      return const Center(child: Text('할 일이 없습니다.'));
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        final todo = todos[index];
                        return TodoCard(
                          todo: todo,
                          showProjectTitle: false,
                          showDateRange: true,
                          todoTitleTextStyle: AppTextStyles.body1.copyWith(
                            color: AppColors.grey800,
                          ),
                        );
                      },
                      separatorBuilder:
                          (context, index) => const SizedBox(height: 8),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: SizedBox(
            height: 48,
            width: 129,
            child: FloatingActionButton.extended(
              heroTag: 'uniqueTagForThisPage',
              backgroundColor: AppColors.primary500,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTodoPage(projectId: projectId),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: Text('할 일 추가', style: AppTextStyles.subtitle1),
            ),
          ),
        ),
      ),
    );
  }
}
