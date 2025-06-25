import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:todomodu_app/features/user/presentation/pages/main/main_page.dart';
import 'package:todomodu_app/features/user/presentation/providers/auth_providers.dart';
import 'package:todomodu_app/features/user/presentation/widgets/login_button.dart';
import 'package:todomodu_app/features/user/presentation/widgets/terms_agreement_content.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';
import 'package:todomodu_app/shared/utils/navigate_to_page.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  Future<void> handleLogin({
    required BuildContext context,
    required Future<dynamic> Function() loginMethod,
  }) async {
    final userCred = await loginMethod();
    if (userCred != null) {
      showTermsModal(context);
    }
  }

  Future<void> showTermsModal(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder: (_) => const TermsAgreementContent(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.read(authProvider);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, AppColors.primary50],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(flex: 2),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: SizedBox(
                  width: double.infinity,
                  child: SvgPicture.asset('assets/images/login_img.svg'),
                ),
              ),
              const SizedBox(height: 26),
              const Text(
                textAlign: TextAlign.center,
                '투두모두와 함께\n하루를 계획해보세요!',
                style: AppTextStyles.header1,
              ),
              Text(
                '쉽고 간편한 스케줄러를 만나보세요',
                style: AppTextStyles.body3.copyWith(color: AppColors.grey400),
              ),
              const SizedBox(height: 110),
              LoginButton(
                platform: '애플',
                path: 'assets/images/apple_logo.png',
                onPressed:
                    () => handleLogin(
                      context: context,
                      loginMethod: auth.signInWithApple,
                    ),
              ),
              const SizedBox(height: 8),
              LoginButton(
                platform: '카카오',
                color: Colors.yellow,
                path: 'assets/images/kakao_logo.png',
                onPressed:
                    () => handleLogin(
                      context: context,
                      loginMethod: auth.signInWithKakao,
                    ),
              ),
              const SizedBox(height: 8),
              LoginButton(
                platform: '구글',
                path: 'assets/images/google_logo.png',
                onPressed:
                    () => handleLogin(
                      context: context,
                      loginMethod: auth.signInWithGoogle,
                    ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
