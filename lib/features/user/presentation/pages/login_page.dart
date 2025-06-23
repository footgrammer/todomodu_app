import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_template.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:todomodu_app/features/user/presentation/pages/main/main_page.dart';
import 'package:todomodu_app/features/user/presentation/providers/auth_providers.dart';
import 'package:todomodu_app/features/user/presentation/widgets/login_button.dart';
import 'package:todomodu_app/shared/constants/app_colors.dart';
import 'package:todomodu_app/shared/utils/navigate_to_page.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.read(authProvider);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Spacer(),
            SvgPicture.asset('assets/images/login_img.svg'),
            const Text(
              textAlign: TextAlign.center,
              '투무모두와 함께\n하루를 계획해보세요!',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const Text(
              '쉽고 간편한 스케줄러를 만나보세요',
              style: TextStyle(color: AppColors.grey500),
            ),
            Spacer(),
            Builder(
              builder: (context) {
                return LoginButton(
                  path: 'assets/images/apple_login.png',
                  onPressed: () async {
                    final userCred = await auth.signInWithApple();
                    if (userCred != null) {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setString('accessToken', 'your_token_here');
                      replaceAllWithPage(context, const MainPage());
                    }
                  },
                );
              },
            ),
            const SizedBox(height: 8),
            LoginButton(
              path: 'assets/images/kakao_login.png',
              onPressed: () async {
                checkKakao();
                // final userCred = await auth.signInWithKakao();
                // if (userCred != null) {
                //   final prefs = await SharedPreferences.getInstance();
                //   prefs.setString('accessToken', 'your_token_here');
                //   replaceAllWithPage(context, const MainPage());
                // }
              },
            ),
            const SizedBox(height: 8),
            LoginButton(
              path: 'assets/images/google_login.png',
              onPressed: () async {
                final userCred = await auth.signInWithGoogle();
                if (userCred != null) {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setString('accessToken', 'your_token_here');
                  replaceAllWithPage(context, const MainPage());
                }
              },
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  void checkKakao() async {
    try {
      final isInstalled = await isKakaoTalkInstalled();
      print('isInstalled : ${isInstalled}');
      // final token =
      //     isInstalled
      //         ? await UserApi.instance.loginWithKakaoTalk()
      //         : await UserApi.instance.loginWithKakaoAccount();
      final token = await UserApi.instance.loginWithKakaoAccount();
      print('token : ${token}');
      final credential = OAuthProvider(
        "oidc.kakao",
      ).credential(accessToken: token.accessToken, idToken: token.idToken);
      print('credential : ${credential}');
    } catch (e, stack) {
      print('❌ kakao login error: $e');
      print('📌 Stack trace:\n$stack');
    }
  }
}
