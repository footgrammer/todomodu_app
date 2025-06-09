
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const SubmitButton({
    required this.label,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 70),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[300],
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              )
            ),
          onPressed: onPressed,
          child: Text(label),
        ),
      ),
    );
  }
}