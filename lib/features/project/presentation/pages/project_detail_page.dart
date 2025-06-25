// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intl/intl.dart';
// import 'package:todomodu_app/features/project/presentation/providers/project_providers.dart';
// import 'package:todomodu_app/features/project/presentation/widgets/project_detail/project_tab_bar.dart';
// import 'package:todomodu_app/features/todo/domain/entities/todo.dart';
// import 'package:todomodu_app/features/todo/presentation/pages/add_todo_page.dart';
// import 'package:todomodu_app/features/todo/presentation/providers/todo_list_viewmodel_provider.dart';
// import 'package:todomodu_app/features/todo/presentation/widgets/todo_card/todo_card.dart';
// import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
// import 'package:todomodu_app/features/todo/presentation/widgets/subtask/add_subtask_list.dart';
// import 'package:todomodu_app/shared/themes/app_theme.dart';

// class ProjectDetailPage extends ConsumerWidget {
//   final String projectId;

//   const ProjectDetailPage({super.key, required this.projectId});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final viewModel = ref.watch(todoListViewModelProvider);
//     final todosStream = viewModel.todosStream(projectId);

//     final projectAsync = ref.watch(projectProvider(projectId));

//     return projectAsync.when(
//       loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
//       error: (e, _) => Scaffold(body: Center(child: Text('프로젝트 로딩 실패: $e'))),
//       data: (project) {
//         final projectTitle = project.title;
//         final startDate = DateFormat('yyyy.MM.dd').format(project.startDate);
//         final endDate = DateFormat('yyyy.MM.dd').format(project.endDate);
//         final progress = project.progress;
//         final projectMembers = project.members;

//         return DefaultTabController(
//           length: 3,
//           child: Scaffold(
//             appBar: AppBar(
//               title: const Text('프로젝트 상세'), // 기존 appbar 수정 안함
//               leading: const BackButton(),
//               actions: [
//                 PopupMenuButton<String>(
//                   menuPadding: const EdgeInsets.symmetric(horizontal: 9),
//                   icon: const Icon(Icons.more_vert),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   offset: const Offset(-10, 40),
//                   color: Colors.white,
//                   onSelected: (value) {
//                     switch (value) {
//                       case 'edit':
//                         break;
//                       case 'leave':
//                         break;
//                     }
//                   },
//                   itemBuilder: (context) => [
//                     PopupMenuItem(
//                       value: 'edit',
//                       padding: EdgeInsets.zero,
//                       child: Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                           '프로젝트 정보 수정하기',
//                           style: AppTextStyles.body2.copyWith(color: AppColors.grey800),
//                         ),
//                       ),
//                     ),
//                     PopupMenuItem(
//                       value: 'leave',
//                       padding: EdgeInsets.zero,
//                       child: Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                           '프로젝트 나가기',
//                           style: AppTextStyles.body2.copyWith(color: AppColors.grey800),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(width: 14),
//               ],
//             ),
//             body: SafeArea(
//               bottom: true,
//               minimum: const EdgeInsets.only(bottom: 34),
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(right: 24, left: 24, top: 8),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // ✅ 프로젝트 제목에 실제 데이터 연결
//                         Text(
//                           projectTitle,
//                           style: AppTextStyles.header2.copyWith(color: AppColors.grey800),
//                         ),
//                         const SizedBox(height: 32),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             _dateColumn('시작일', startDate),
//                             _dateColumn('종료일', endDate),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   '진척도',
//                                   style: AppTextStyles.subtitle3.copyWith(color: AppColors.grey500),
//                                 ),
//                                 Row(
//                                   children: [
//                                     Text(
//                                       '${(progress * 100).round()}%',
//                                       style: AppTextStyles.body2.copyWith(color: AppColors.grey800),
//                                     ),
//                                     const SizedBox(width: 7),
//                                     SizedBox(
//                                       width: 56,
//                                       height: 8,
//                                       child: LinearProgressIndicator(
//                                         value: progress,
//                                         backgroundColor: AppColors.grey200,
//                                         color: AppColors.primary500,
//                                         borderRadius: BorderRadius.circular(100),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 32),
//                         Text('팀원', style: AppTextStyles.subtitle1.copyWith(color: AppColors.grey800)),
//                         const SizedBox(height: 8),
//                         Row(
//                           children: [
//                             for (var member in projectMembers)
//                               Padding(
//                                 padding: const EdgeInsets.only(right: 8),
//                                 child: CircleAvatar(
//                                   radius: 16,
//                                   backgroundImage: member.profileImageUrl.isNotEmpty
//                                       ? NetworkImage(member.profileImageUrl)
//                                       : null,
//                                   child: member.profileImageUrl.isEmpty
//                                       ? Text(member.name[0])
//                                       : null,
//                                 ),
//                               ),
//                             const Spacer(),
//                             OutlinedButton.icon(
//                               onPressed: () {},
//                               icon: Icon(Icons.add, color: AppColors.primary600),
//                               label: Text('팀원 초대', style: AppTextStyles.subtitle3.copyWith(color: AppColors.primary600)),
//                               style: OutlinedButton.styleFrom(
//                                 backgroundColor: AppColors.primary50,
//                                 side: BorderSide(color: AppColors.primary600),
//                                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
//                                 padding: const EdgeInsets.all(10),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 28),
//                         const ProjectTabBar(),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(color: AppColors.grey75),
//                       child: StreamBuilder<List<Todo>>(
//                         stream: todosStream,
//                         builder: (context, snapshot) {
//                           if (snapshot.connectionState == ConnectionState.waiting) {
//                             return const Center(child: CircularProgressIndicator());
//                           }
//                           if (snapshot.hasError) {
//                             return Center(child: Text('에러 발생: ${snapshot.error}'));
//                           }
//                           final todos = snapshot.data ?? [];
//                           if (todos.isEmpty) {
//                             return const Center(child: Text('할 일이 없습니다.'));
//                           }
//                           return ListView.separated(
//                             padding: const EdgeInsets.only(top: 16, right: 24, left: 24, bottom: 34),
//                             itemCount: todos.length,
//                             itemBuilder: (context, index) {
//                               final todo = todos[index];
//                               return Column(
//                                 children: [
//                                   TodoCard(
//                                     todo: todo,
//                                     showProjectTitle: false,
//                                     showDateRange: true,
//                                     todoTitleTextStyle: AppTextStyles.body1.copyWith(color: AppColors.grey800),
//                                   ),
//                                 ],
//                               );
//                             },
//                             separatorBuilder: (context, index) => const SizedBox(height: 8),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             floatingActionButton: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               child: SizedBox(
//                 height: 48,
//                 width: 129,
//                 child: FloatingActionButton.extended(
//                   heroTag: 'uniqueTagForThisPage',
//                   backgroundColor: AppColors.primary500,
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (_) => AddTodoPage(projectId: projectId, projectMembers: [],)),
//                     );
//                   },
//                   icon: const Icon(Icons.add),
//                   label: Text('할 일 추가', style: AppTextStyles.subtitle1),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _dateColumn(String label, String value) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label, style: AppTextStyles.subtitle3.copyWith(color: AppColors.grey500)),
//         Text(value, style: AppTextStyles.body2.copyWith(color: AppColors.grey800)),
//       ],
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todomodu_app/features/project/presentation/providers/project_providers.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project_detail/project_info_header.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project_detail/project_member_section.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project_detail/project_tab_bar.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

class ProjectDetailPage extends ConsumerWidget {
  final String projectId;

  const ProjectDetailPage({super.key, required this.projectId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectAsync = ref.watch(projectProvider(projectId));

    return projectAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('프로젝트 로딩 실패: $e'))),
      data: (project) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('프로젝트 상세'),
              leading: const BackButton(),
              actions: [_popupMenu()],
            ),
            body: SafeArea(
              bottom: true,
              minimum: const EdgeInsets.only(bottom: 34),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProjectInfoHeader(project: project),
                        const SizedBox(height: 32),
                        ProjectMemberSection(members: project.members),
                        const SizedBox(height: 28),
                      ],
                    ),
                  ),
                  Expanded(child: ProjectTabBar(projectId: projectId)),
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                  onPressed: () {
                    Navigator.pushNamed(context, '/add-todo', arguments: projectId);
                  },
                  icon: const Icon(Icons.add),
                  label: Text('할 일 추가', style: AppTextStyles.subtitle1),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _popupMenu() {
    return Row(
      children: [
        PopupMenuButton<String>(
          menuPadding: const EdgeInsets.symmetric(horizontal: 9),
          icon: const Icon(Icons.more_vert),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          offset: const Offset(-10, 40),
          color: Colors.white,
          onSelected: (value) {
            if (value == 'edit') {
              // 프로젝트 수정
            } else if (value == 'leave') {
              // 프로젝트 나가기
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'edit',
              padding: EdgeInsets.zero,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('프로젝트 정보 수정하기', style: AppTextStyles.body2.copyWith(color: AppColors.grey800)),
              ),
            ),
            PopupMenuItem(
              value: 'leave',
              padding: EdgeInsets.zero,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('프로젝트 나가기', style: AppTextStyles.body2.copyWith(color: AppColors.grey800)),
              ),
            ),
          ],
        ),
        const SizedBox(width: 14),
      ],
    );
  }
}
