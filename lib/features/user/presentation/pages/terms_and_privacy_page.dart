import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TermsAndPrivacyPage extends StatefulWidget {
  const TermsAndPrivacyPage({super.key});

  @override
  State<TermsAndPrivacyPage> createState() => _TermsAndPrivacyPageState();
}

class _TermsAndPrivacyPageState extends State<TermsAndPrivacyPage> {
  String termsText = '';

  @override
  void initState() {
    super.initState();
    loadTermsText();
  }

  Future<void> loadTermsText() async {
    final loadedText = await rootBundle.loadString('assets/terms/terms.txt');
    setState(() {
      termsText = loadedText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          '이용약관 및 개인정보 처리방침',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: termsText.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Text(
                termsText,
                style: const TextStyle(fontSize: 14, height: 1.6),
              ),
            ),
    );
  }
}
