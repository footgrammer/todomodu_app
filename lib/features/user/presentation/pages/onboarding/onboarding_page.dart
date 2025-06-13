import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todomodu_app/features/user/presentation/pages/login_page.dart';
import 'package:todomodu_app/features/user/presentation/pages/onboarding/onboarding_screen.dart';
import 'package:todomodu_app/shared/constants/app_colors.dart';
import 'package:todomodu_app/shared/utils/navigate_to_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      'path': 'assets/images/onboarding1_img.svg',
      'title': '내 일정을 한눈에',
      'description': '팀플, 업무, 여행 계획까지!\n내 일상 속 프로젝트들을 간편하게 정리해요.',
    },
    {
      'path': 'assets/images/onboarding2_img.svg',
      'title': '지금 해야할 일만 딱',
      'description': '복잡한 계획은 잠시 미뤄두세요.\n오늘 해야 할 일만 골라 보여드릴게요.',
    },
    {
      'path': 'assets/images/onboarding3_img.svg',
      'title': '계획이 막막할 땐 AI에게',
      'description': '“뭐부터 해야 하지?” 고민될 때,\nAI가 할 일 목록을 똑똑하게 제안해드려요.',
    },
    {
      'path': 'assets/images/onboarding4_img.svg',
      'title': '이제, 시작해볼까요?',
      'description': '간단한 정보만 적으면\n당신만의 프로젝트를 바로 만들 수 있어요.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary50,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: onboardingData.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                final data = onboardingData[index];
                return OnboardingScreen(
                  path: data['path']!,
                  title: data['title']!,
                  description: data['description']!,
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(onboardingData.length, (index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
                width: _currentPage == index ? 20 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color:
                      _currentPage == index
                          ? AppColors.primary500
                          : AppColors.grey300,
                  borderRadius: BorderRadius.circular(20),
                ),
              );
            }),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    log('시작하기 버튼 클릭');
                    replaceAllWithPage(context, LoginPage());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary500,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    '시작하기',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
