import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todomodu_app/features/ai/presentation/pages/project_create_test_page.dart';
import 'package:todomodu_app/features/project/data/models/Project.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project/project_card_list.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project/project_search_bar.dart';
import 'package:todomodu_app/shared/utils/navigate_to_page.dart';
import 'package:todomodu_app/shared/widgets/custom_icon.dart';

class User {
  final String id;
  final String name;

  User({required this.id, required this.name});
}

class Todo {
  final String id;
  final String content;
  final bool isDone;

  Todo({required this.id, required this.content, required this.isDone});
}

final dummyOwner = User(id: 'u1', name: '홍길동');
final dummyMembers = [User(id: 'u2', name: '김철수'), User(id: 'u3', name: '이영희')];

final dummyTodos = [
  Todo(id: 't1', content: '첫 번째 할 일', isDone: true),
  Todo(id: 't2', content: '두 번째 할 일', isDone: false),
];

final List<Project> projects = [
  Project(
    id: 'p1',
    title: '프로젝트 1의 제목입니다',
    description: '이것은 첫 번째 프로젝트입니다.',
    color: Color(0xFF9FB2DA), // 연한 파란색
    startDate: DateTime(2025, 5, 29),
    endDate: DateTime(2025, 7, 4),
    // owner: dummyOwner,
    // members: dummyMembers,
    // todos: dummyTodos,
    invitationCode: 'INV123',
    isDone: false,
  ),
  Project(
    id: 'p2',
    title: '프로젝트 2의 제목입니다',
    description: '두 번째 프로젝트에 대한 설명입니다.',
    color: Color(0xFFB769A3), // 연한 초록색
    startDate: DateTime(2025, 6, 1),
    endDate: DateTime(2025, 7, 15),
    // owner: dummyOwner,
    // members: dummyMembers,
    // todos: dummyTodos,
    invitationCode: 'INV456',
    isDone: false,
  ),
  Project(
    id: 'p3',
    title: '프로젝트 3의 제목입니다',
    description: '세 번째 프로젝트를 위한 테스트 데이터입니다.',
    color: Color(0xFF706FBF), // 연한 주황색
    startDate: DateTime(2025, 6, 10),
    endDate: DateTime(2025, 8, 1),
    // owner: dummyOwner,
    // members: dummyMembers,
    // todos: dummyTodos,
    invitationCode: 'INV789',
    isDone: true,
  ),
  Project(
    id: 'p3',
    title: '프로젝트 4의 제목입니다',
    description: '세 번째 프로젝트를 위한 테스트 데이터입니다.',
    color: Color(0xFF706FBF), // 연한 주황색
    startDate: DateTime(2025, 6, 10),
    endDate: DateTime(2025, 8, 1),
    // owner: dummyOwner,
    // members: dummyMembers,
    // todos: dummyTodos,
    invitationCode: 'INV789',
    isDone: true,
  ),
  Project(
    id: 'p3',
    title: '프로젝트 5의 제목입니다',
    description: '세 번째 프로젝트를 위한 테스트 데이터입니다.',
    color: Color(0xFF706FBF), // 연한 주황색
    startDate: DateTime(2025, 6, 10),
    endDate: DateTime(2025, 8, 1),
    // owner: dummyOwner,
    // members: dummyMembers,
    // todos: dummyTodos,
    invitationCode: 'INV789',
    isDone: true,
  ),
];

final projectCodeControllerProvider =
    Provider.autoDispose<TextEditingController>(
      (ref) => TextEditingController(),
    );

class ProjectPage extends ConsumerWidget {
  const ProjectPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(projectCodeControllerProvider);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // ✅ 현재 포커스 해제
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: SvgPicture.asset('assets/images/top_app_bar_logo_img.svg'),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: IconButton(
                onPressed: () {
                  log('알림 버튼 클릭');
                },
                icon: CustomIcon(name: 'bell'),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              ProjectSearchBar(controller: controller),
              SizedBox(height: 16),
              ProjectCardList(projects: projects),
            ],
          ),
        ),
        // ➕ 플로팅 버튼
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            navigateToPage(context, ProjectCreateTestPage());
          },
          label: Text(
            '프로젝트 추가',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          icon: Icon(Icons.add, color: Colors.white),
          backgroundColor: Color(0xFF5752EA),
        ),
      ),
    );
  }
}
