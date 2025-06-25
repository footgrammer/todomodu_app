import 'package:flutter/material.dart';
import 'package:todomodu_app/features/notice/presentation/widgets/notice_list/expanded_text_box/expand_animate_text_box.dart';
import 'package:todomodu_app/features/notice/presentation/widgets/notice_list/expanded_text_box/fade_in_text_toggle_button.dart';
import 'package:todomodu_app/features/notice/presentation/widgets/notice_list/expanded_text_box/notice_check_button.dart';

class ExpandedTextWidget extends StatefulWidget {
  const ExpandedTextWidget({required this.content, super.key});
  final String content;

  @override
  State<ExpandedTextWidget> createState() => _ExpandedTextWidgetState();
}

class _ExpandedTextWidgetState extends State<ExpandedTextWidget>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;

  final _textStyle = const TextStyle(
    fontSize: 14,
    height: 1.4, // 줄 간격
    letterSpacing: 0.1, // 글자 간격
  );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isOverflowing = _exceedsLineLimit(
          text: widget.content,
          textStyle: _textStyle,
          maxWidth: constraints.maxWidth,
          maxLines: 3,
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpandAnimateTextBox(content: widget.content, expanded: _expanded),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // NoticeCheckButton(isChecked: false,),
                if (isOverflowing)
                  FadeInTextToggleButton(
                    toggleTrueText: '접기',
                    toggleFalseText: '펼치기',
                    toggleFunction:
                        () => {
                          setState(() {
                            _expanded = !_expanded;
                          }),
                        },
                  ),
              ],
            ),
          ],
        );
      },
    );
  }

  bool _exceedsLineLimit({
    required String text,
    required TextStyle textStyle,
    required double maxWidth,
    required int maxLines,
  }) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: textStyle),
      textDirection: TextDirection.ltr,
      maxLines: null, // 전체 줄수 계산용이므로 null로 둔다
    )..layout(maxWidth: maxWidth);

    final actualLines = textPainter.computeLineMetrics().length;
    return actualLines > maxLines;
  }
}
