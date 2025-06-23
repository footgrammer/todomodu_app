import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

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
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () => Navigator.of(context).pop(),
                child: const SizedBox(
                  width: 36,
                  height: 36,
                  child: Icon(Icons.arrow_back_ios_new, size: 18),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '이용약관 및 개인정보 처리방침',
              style: AppTextStyles.header3.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
      body:
          termsText.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Text(
                  termsText,
                  style: AppTextStyles.body2.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
    );
  }
}
