import 'package:flutter/material.dart';

class ExpandAnimateTextBox extends StatelessWidget {
  final String content;
  final bool expanded;

  const ExpandAnimateTextBox({
    required this.content,
    required this.expanded,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: ConstrainedBox(
        constraints: expanded
            ? BoxConstraints()
            : BoxConstraints(maxHeight: 60),
        child: Text(
          content,
          style: TextStyle(fontSize: 14, height: 1.4),
          softWrap: true,
          overflow:
              expanded ? TextOverflow.visible : TextOverflow.ellipsis,
          maxLines: expanded ? null : 3,
        ),
      ),
    );
  }
}
