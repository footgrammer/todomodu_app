import 'package:flutter/material.dart';
import 'package:todomodu_app/features/ai/presentation/pages/project_create_test_page.dart';
import 'package:todomodu_app/features/notice/presentation/pages/notice_create_page.dart';
import 'package:todomodu_app/features/notice/presentation/pages/notice_list_page.dart';
import 'package:todomodu_app/features/project/presentation/pages/project_detail_page.dart';
import 'package:todomodu_app/features/project/presentation/pages/project_page.dart';
import 'package:todomodu_app/features/user/presentation/pages/login_page.dart';
import 'package:todomodu_app/features/user/presentation/pages/main/main_page.dart';
import 'package:todomodu_app/features/user/presentation/pages/my_page.dart';
import 'package:todomodu_app/features/user/presentation/pages/onboarding/onboarding_page.dart';
import 'package:todomodu_app/features/user/presentation/pages/splash/splash_page.dart';
import 'package:todomodu_app/shared/constants/app_colors.dart';

class TodomoduApp extends StatelessWidget {
  const TodomoduApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todomodu App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary500),
      ),
      home: ProjectDetailPage(projectId: 'test-project-id'),
    );
  }

  ElevatedButton moveToPage(BuildContext context, Widget page, String text) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return page;
            },
          ),
        );
      },
      child: Text(text),
    );
  }
}
