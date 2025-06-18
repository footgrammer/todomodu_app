import 'package:flutter/material.dart';

class CommonElevatedButton extends StatelessWidget {
  String text;
  Color buttonColor;
  final VoidCallback onPressed;

  CommonElevatedButton({
    required this.text,
    required this.buttonColor,
    required this.onPressed,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 56),
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
