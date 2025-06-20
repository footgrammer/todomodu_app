import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/features/user/presentation/pages/closed_project_list_page.dart';
import 'package:todomodu_app/features/user/presentation/pages/login_page.dart';
import 'package:todomodu_app/features/user/presentation/pages/notification_settings_page.dart';
import 'package:todomodu_app/features/user/presentation/pages/terms_and_privacy_page.dart';
import 'package:todomodu_app/features/user/presentation/providers/auth_providers.dart';
import 'package:todomodu_app/features/user/presentation/providers/user_providers.dart';
import 'package:todomodu_app/features/user/presentation/viewmodels/user_view_model.dart';
import 'package:todomodu_app/features/user/presentation/widgets/custom_menu_bar.dart';
import 'package:todomodu_app/features/user/presentation/widgets/edit_nickname_dialog.dart';
import 'package:todomodu_app/features/user/presentation/widgets/logout_dialog.dart';
import 'package:todomodu_app/features/user/presentation/widgets/my_profile_image.dart';
import 'package:todomodu_app/shared/utils/navigate_to_page.dart';
import 'package:todomodu_app/shared/widgets/custom_icon.dart';

class MyPage extends ConsumerStatefulWidget {
  const MyPage({super.key});

  @override
  ConsumerState<MyPage> createState() => _MyPageState();
}

class _MyPageState extends ConsumerState<MyPage> {
  UserEntity? _user;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    final user = await ref.read(userViewModelProvider.notifier).fetchUser();
    log('loadUser 결과: $user');
    if (user == null) {
      final authRepo = ref.read(authProvider);
      await authRepo.signOut();
      replaceAllWithPage(context, LoginPage());
    }
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Padding(
          padding: EdgeInsets.only(left: 8),
          child: Text('마이', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        actions: [
          IconButton(
            onPressed: () {
              log('알림 버튼 클릭');
            },
            icon: const CustomIcon(name: 'bell'),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MyProfileImage(user: _user!),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 4, 4, 0),
                    child: Text(
                      _user!.name,
                      style: const TextStyle(fontSize: 22),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      log('닉네임 변경 버튼 클릭');
                      showDialog(
                        context: context,
                        builder:
                            (context) =>
                                EditNicknameDialog(userId: _user!.userId),
                      );
                    },
                    child: Container(
                      width: 28,
                      height: 28,
                      color: Colors.transparent,
                      child: CustomIcon(
                        name: 'Edit_Pencil_Line_01',
                        size: 18,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              CustomMenuBar(
                text: '종료된 프로젝트',
                onPressed: () {
                  navigateToPage(context, const ClosedProjectListPage());
                },
              ),
              CustomMenuBar(
                text: '알림 설정',
                onPressed: () {
                  navigateToPage(context, const NotificationSettingsPage());
                },
              ),
              const SizedBox(height: 18),
              CustomMenuBar(
                text: '이용약관 및 개인정보 처리방침',
                onPressed: () {
                  navigateToPage(context, const TermsAndPrivacyPage());
                },
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('버전 정보', style: TextStyle(fontSize: 18)),
                    Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Text(
                        '1.0.0',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              CustomMenuBar(
                text: '로그아웃',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const LogoutDialog(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
