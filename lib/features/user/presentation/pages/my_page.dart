import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:todomodu_app/features/user/data/datasources/auth_data_source.dart';
import 'package:todomodu_app/features/user/presentation/pages/closed_project_list_page.dart';
import 'package:todomodu_app/features/user/presentation/pages/login_page.dart';
import 'package:todomodu_app/features/user/presentation/pages/notification_settings_page.dart';
import 'package:todomodu_app/features/user/presentation/pages/splash/splash_page.dart';
import 'package:todomodu_app/features/user/presentation/pages/terms_and_privacy_page.dart';
import 'package:todomodu_app/features/user/presentation/providers/auth_providers.dart';
import 'package:todomodu_app/features/user/presentation/providers/user_providers.dart';
import 'package:todomodu_app/features/user/presentation/viewmodels/user_view_model.dart';
import 'package:todomodu_app/features/user/presentation/widgets/custom_menu_bar.dart';
import 'package:todomodu_app/features/user/presentation/widgets/edit_nickname_dialog.dart';
import 'package:todomodu_app/features/user/presentation/widgets/custom_dialog.dart';
import 'package:todomodu_app/features/user/presentation/widgets/my_profile_image.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';
import 'package:todomodu_app/shared/utils/navigate_to_page.dart';
import 'package:todomodu_app/shared/widgets/custom_icon.dart';

class MyPage extends ConsumerWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userViewModelProvider);
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
                            builder:
                                (context) => CustomDialog(
                                  title: '로그아웃',
                                  subTitle: '로그아웃하시겠습니까?',
                                  onConfirmed: () async {
                                    final authRepo = ref.read(authProvider);
                                    await authRepo.signOut();
                                    ref.invalidate(userViewModelProvider); // userViewModel dispose
                                    Navigator.of(context)
                                      ..pop()
                                      ..pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) => LoginPage(),
                                        ),
                                      );
                                  },
                                ),
                          );
                        },
                      ),
                      CustomMenuBar(
                        text: '회원 탈퇴',
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder:
                                (context) => CustomDialog(
                                  title: '탈퇴',
                                  subTitle: '정말 탈퇴하시겠습니까?',
                                  onConfirmed: () async {
                                    withdraw(context, ref);
                                  },
                                ),
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

Future<void> reauthenticateWithGoogle(WidgetRef ref) async {
  final authDataSource = ref.read(authDataSourceProvider);
  final credential = await authDataSource.signInWithGoogle();

  await FirebaseAuth.instance.currentUser!.reauthenticateWithCredential(
    credential!,
  );
}

Future<void> reauthenticateWithApple(WidgetRef ref) async {
  final authDataSource = ref.read(authDataSourceProvider);
  final credential = await authDataSource.signInWithApple();

  await FirebaseAuth.instance.currentUser!.reauthenticateWithCredential(
    credential!,
  );
}

Future<void> reauthenticateWithKakao(WidgetRef ref) async {
  final authDataSource = ref.read(authDataSourceProvider);
  final credential = await authDataSource.signInWithKakao();

  await FirebaseAuth.instance.currentUser!.reauthenticateWithCredential(
    credential!,
  );
}

Future<void> withdraw(BuildContext context, WidgetRef ref) async {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    log('사용자 없음');
    return;
  }

  try {
    final providerIds = user.providerData.map((e) => e.providerId).toList();

    if (providerIds.contains('google.com')) {
      log('구글 연동 유저');
      await reauthenticateWithGoogle(ref);
    } else if (providerIds.contains('apple.com')) {
      log('애플 연동 유저');
      await reauthenticateWithApple(ref);
    } else if (providerIds.contains('oidc.kakao')) {
      log('카카오 연동 유저');
      await reauthenticateWithKakao(ref);
    }

    await FirebaseAuth.instance.currentUser!.delete(); // firebaseAuth 계정 삭제
    log('firebaseAuth 계정 삭제');
    final userId = user.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .delete(); // 유저 문서 삭제
    log('문서 삭제 완료');
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // 분기 초기화
    log('분기 초기화');

    ref.invalidate(userViewModelProvider); // userViewModel dispose

    replaceAllWithPage(context, SplashPage()); // 스플래시화면, 로그인화면 고민중
  } catch (e) {
    log('회원탈퇴 실패: $e');
  }
}
