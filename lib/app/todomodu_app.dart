import 'package:flutter/material.dart';
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
      home: SplashPage(),
    );
  }
}
