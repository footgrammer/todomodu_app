import 'package:flutter/material.dart';
import 'package:todomodu_app/features/notice/presentation/pages/notice_create_page.dart';
import 'package:todomodu_app/features/project/presentation/pages/project_detail_page.dart';
import 'package:todomodu_app/features/project/presentation/pages/project_page.dart';
import 'package:todomodu_app/features/user/presentation/pages/login_page.dart';
import 'package:todomodu_app/features/user/presentation/pages/my_page.dart';

class TodomoduApp extends StatelessWidget {
  const TodomoduApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todomodu App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              children: [
                Builder(
                  builder: (context) {
                    return moveToPage(context, LoginPage(), 'LoginPage');
                  }
                ),
                Builder(
                  builder: (context) {
                    return moveToPage(context, ProjectPage(), 'projectPage');
                  }
                ),
                Builder(
                  builder: (context) {
                    return moveToPage(context, NoticeCreatePage(), 'noticeCreatePage');
                  }
                ),
                Builder(
                  builder: (context) {
                    return moveToPage(context, ProjectDetailPage(), 'projectDetailPage');
                  }
                ),
                Builder(
                  builder: (context) {
                    return moveToPage(context, MyPage(), 'MyPage');
                  }
                ),
              ],
            ),
          ),
        ),
      ),
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
