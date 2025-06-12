import 'package:flutter/material.dart';

class ClosedProjectListPage extends StatelessWidget {
  const ClosedProjectListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          '종료된 프로젝트',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
