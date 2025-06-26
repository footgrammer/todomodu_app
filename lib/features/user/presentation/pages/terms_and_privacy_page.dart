import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

class TermsAndPrivacyPage extends StatefulWidget {
  final bool scrollToPrivacy; // true면 개인정보 처리방침으로 이동

  const TermsAndPrivacyPage({super.key, this.scrollToPrivacy = false});

  @override
  State<TermsAndPrivacyPage> createState() => _TermsAndPrivacyPageState();
}

class _TermsAndPrivacyPageState extends State<TermsAndPrivacyPage> {
  String termsText = '';
  final ScrollController _scrollController = ScrollController();

  final _privacyKey = GlobalKey();

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

    // 약간의 delay 후 스크롤 이동
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.scrollToPrivacy) {
        _scrollToPrivacy();
      }
    });
  }

  void _scrollToPrivacy() {
    final ctx = _privacyKey.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
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
      body: termsText.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: _buildTextWithKey(theme),
            ),
    );
  }

  /// 개인정보 처리방침 위치에 key를 삽입
  Widget _buildTextWithKey(ThemeData theme) {
    // 문자열 분리
    final splitParts = termsText.split('■ 개인정보 처리방침');

    if (splitParts.length < 2) {
      return Text(
        termsText,
        style: AppTextStyles.body2.copyWith(color: theme.colorScheme.onSurface),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          splitParts[0],
          style: AppTextStyles.body2.copyWith(color: theme.colorScheme.onSurface),
        ),
        const SizedBox(height: 24),
        Container(
          key: _privacyKey,
          child: Text(
            '■ 개인정보 처리방침\n${splitParts[1]}',
            style: AppTextStyles.body2.copyWith(color: theme.colorScheme.onSurface),
          ),
        ),
      ],
    );
  }
}
