import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todomodu_app/features/user/presentation/pages/login_page.dart'
    show LoginPage;
import 'package:todomodu_app/features/user/presentation/pages/main/main_page.dart';
import 'package:todomodu_app/features/user/presentation/pages/onboarding/onboarding_page.dart';
import 'package:todomodu_app/shared/constants/app_colors.dart';
import 'package:todomodu_app/shared/utils/navigate_to_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      _checkAndNavigate();
    });
  }

  Future<void> _checkAndNavigate() async {
    final prefs = await SharedPreferences.getInstance();
    final hasSeenOnboarding = prefs.getBool('onboardingSeen') ?? false;
    final accessToken = prefs.getString('accessToken');

    if (!hasSeenOnboarding) {
      replaceAllWithPage(context, OnboardingPage());
    } else if (accessToken == null || accessToken.isEmpty) {
      replaceAllWithPage(context, const LoginPage());
    } else {
      replaceAllWithPage(context, const MainPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary500,
      body: Center(
        child: SvgPicture.asset('assets/images/splash_logo_img.svg'),
      ),
    );
  }
}
