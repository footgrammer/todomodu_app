import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todomodu_app/features/user/presentation/widgets/custom_menu_bar.dart';
import 'package:todomodu_app/features/user/presentation/widgets/profile_image.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('마이', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            onPressed: () {
              log('알림 버튼 클릭');
            },
            icon: Icon(CupertinoIcons.bell),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 8),
            ProfileImage(),
            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox.square(dimension: 20),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    '사용자 닉네임',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 2),
                GestureDetector(
                  onTap: () {
                    log('닉네임 변경 버튼 클릭');
                  },
                  child: Container(
                    width: 20,
                    height: 20,
                    color: Colors.transparent,
                    child: Icon(Icons.edit_outlined),
                  ),
                ),
              ],
            ),
            Text('address@email.com'),
            const SizedBox(height: 18),
            CustomMenuBar(text: '종료된 프로젝트'),
            CustomMenuBar(text: '알림 설정'),
            const SizedBox(height: 18),
            CustomMenuBar(text: '이용약관 및 개인정보 처리방침'),
            CustomMenuBar(text: '버전 정보'),
            CustomMenuBar(text: '로그아웃'),
          ],
        ),
      ),
    );
  }
}
