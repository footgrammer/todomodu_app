import 'package:flutter/material.dart';
import 'package:todomodu_app/features/user/presentation/pages/login_page.dart';
import 'package:todomodu_app/features/user/presentation/pages/splash/splash_page.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

class TodomoduApp extends StatelessWidget {
  const TodomoduApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todomodu App',

      theme: AppTheme.lightTheme,
      home: LoginPage(),
    );
  }
}
