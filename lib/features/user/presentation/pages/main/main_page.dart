import 'package:flutter/material.dart';
import 'package:todomodu_app/features/notice/presentation/pages/notice_create_page.dart';
import 'package:todomodu_app/features/notice/presentation/pages/notice_list_page.dart';
import 'package:todomodu_app/features/project/presentation/pages/project_detail_page.dart';
import 'package:todomodu_app/features/project/presentation/pages/project_list_page.dart';
import 'package:todomodu_app/features/todo/presentation/pages/add_todo_page.dart';
import 'package:todomodu_app/features/todo/presentation/pages/todo_detail_page.dart';
import 'package:todomodu_app/features/todo/presentation/pages/todo_page.dart';
import 'package:todomodu_app/features/user/presentation/pages/my_page.dart';
import 'package:todomodu_app/shared/constants/app_colors.dart';
import 'package:todomodu_app/shared/widgets/custom_icon.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          ProjectListPage(),
          NoticeListPage(),
          NoticeCreatePage(projectId: '1'),
          MyPage(),
        ],
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      ('Folder 2', '프로젝트'),
      ('List_Check', '할일'),
      ('note', '공지'),
      ('User_01', '마이'),
    ];

    return SafeArea(
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey[300]!)),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(48, 4, 48, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < items.length; i++) ...[
                GestureDetector(
                  onTap: () => onTap(i),
                  behavior: HitTestBehavior.translucent,
                  child: SizedBox(
                    width: 46,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomIcon(
                          name: items[i].$1,
                          size: 24,
                          color:
                              i == currentIndex
                                  ? AppColors.primary700
                                  : AppColors.grey300,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          items[i].$2,
                          style: TextStyle(
                            fontSize: 12,
                            color:
                                i == currentIndex
                                    ? AppColors.primary700
                                    : AppColors.grey300,
                            fontWeight:
                                i == currentIndex
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (i != items.length - 1) const Spacer(),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
