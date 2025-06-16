import 'package:flutter/material.dart';

class TermsAndPrivacyPage extends StatelessWidget {
  const TermsAndPrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('이용약관 및 개인정보 처리방침',style: TextStyle(fontWeight: FontWeight.bold),),
      ),
    );
  }
}