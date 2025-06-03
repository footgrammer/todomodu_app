import 'package:flutter/material.dart';
import 'package:todomodu_app/features/project/presentation/pages/project_page.dart';

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
      home: ProjectPage(),
    );
  }
}
