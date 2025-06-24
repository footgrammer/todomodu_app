import 'package:flutter/material.dart';
import 'package:todomodu_app/features/notice/presentation/pages/notice_list_page.dart';
import 'package:todomodu_app/features/project/presentation/pages/project_list_page.dart';
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
          NoticeListPage(),
          MyPage(),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 14),
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.grey200, width: 1)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: CustomIcon(name: 'Folder 2', color: AppColors.grey300),
              label: '프로젝트',
              activeIcon: CustomIcon(
                name: 'Folder 2',
                color: AppColors.primary700,
              ),
            ),
            BottomNavigationBarItem(
              icon: CustomIcon(name: 'List_Check', color: AppColors.grey300),
              label: '할일',
              activeIcon: CustomIcon(
                name: 'List_Check',
                color: AppColors.primary700,
              ),
            ),
            BottomNavigationBarItem(
              icon: CustomIcon(name: 'note', color: AppColors.grey300),
              label: '공지',
              activeIcon: CustomIcon(
                name: 'List_Check',
                color: AppColors.primary700,
              ),
            ),
            BottomNavigationBarItem(
              icon: CustomIcon(name: 'User_01', color: AppColors.grey300),
              label: '마이',
              activeIcon: CustomIcon(
                name: 'List_Check',
                color: AppColors.primary700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
