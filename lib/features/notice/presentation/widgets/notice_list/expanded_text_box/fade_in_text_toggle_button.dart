import 'package:flutter/material.dart';

class FadeInTextToggleButton extends StatefulWidget {
  const FadeInTextToggleButton({
    required this.toggleFunction,
    required this.toggleTrueText,
    required this.toggleFalseText,
    super.key,
  });
  final String toggleTrueText;
  final String toggleFalseText;
  final void Function() toggleFunction;

  @override
  State<FadeInTextToggleButton> createState() => _FadeInTextButtonState();
}

class _FadeInTextButtonState extends State<FadeInTextToggleButton> {
  bool _toggle = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder:
          (child, animation) =>
              FadeTransition(opacity: animation, child: child),
      child: Align(
        alignment: Alignment.centerRight,
        key: ValueKey(_toggle),
        child: TextButton(
          onPressed:
              () => setState(() {
                _toggle = !_toggle;
                widget.toggleFunction();
              }),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_toggle ? widget.toggleTrueText : widget.toggleFalseText),
              Icon(_toggle ? Icons.expand_less : Icons.expand_more, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
