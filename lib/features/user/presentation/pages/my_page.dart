import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/user/presentation/pages/closed_project_list_page.dart';
import 'package:todomodu_app/features/user/presentation/pages/notification_settings_page.dart';
import 'package:todomodu_app/features/user/presentation/pages/terms_and_privacy_page.dart';
import 'package:todomodu_app/features/user/presentation/providers/user_providers.dart';
import 'package:todomodu_app/features/user/presentation/widgets/custom_menu_bar.dart';
import 'package:todomodu_app/features/user/presentation/widgets/edit_nickname_dialog.dart';
import 'package:todomodu_app/features/user/presentation/widgets/logout_dialog.dart';
import 'package:todomodu_app/features/user/presentation/widgets/my_profile_image.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';
import 'package:todomodu_app/shared/utils/navigate_to_page.dart';
import 'package:todomodu_app/shared/widgets/custom_icon.dart';

class MyPage extends ConsumerWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProvider);
    return userAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('$error')),
      data: (user) {
        return user == null
            ? Scaffold()
            : Scaffold(
              appBar: AppBar(
                centerTitle: false,
                title: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: const Text('마이', style: AppTextStyles.header3),
                ),
                actions: [
                  GestureDetector(
                    onTap: () {
                      log('알림 버튼 클릭');
                    },
                    child: Container(
                      width: 36,
                      height: 36,
                      color: Colors.transparent,
                      child: CustomIcon(name: 'bell'),
                    ),
                  ),
                  SizedBox(width: 14),
                ],
              ),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 12, 8, 12),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 96,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            MyProfileImage(user: user),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 4, 0, 0),
                              child: Text(
                                user.name,
                                style: AppTextStyles.body1,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                log('닉네임 변경 버튼 클릭');
                                showDialog(
                                  context: context,
                                  builder:
                                      (context) => EditNicknameDialog(
                                        userId: user.userId,
                                      ),
                                );
                              },
                              child: Container(
                                width: 28,
                                height: 28,
                                color: Colors.transparent,
                                alignment: Alignment.center,
                                child: CustomIcon(
                                  name: 'Edit_Pencil_Line_01',
                                  size: 18,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                      CustomMenuBar(
                        text: '종료된 프로젝트',
                        onPressed: () {
                          navigateToPage(context, ClosedProjectListPage());
                        },
                      ),
                      CustomMenuBar(
                        text: '알림 설정',
                        onPressed: () {
                          navigateToPage(context, NotificationSettingsPage());
                        },
                      ),
                      const SizedBox(height: 18),
                      CustomMenuBar(
                        text: '이용약관 및 개인정보 처리방침',
                        onPressed: () {
                          navigateToPage(context, TermsAndPrivacyPage());
                        },
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('버전 정보', style: TextStyle(fontSize: 18)),
                            Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: Text('1.0.0', style: AppTextStyles.body3),
                            ),
                          ],
                        ),
                      ),
                      CustomMenuBar(
                        text: '로그아웃',
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => LogoutDialog(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
      },
    );
  }
}
