import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key, required this.path, required this.onPressed});

  final String path;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        elevation: 0,
        maximumSize: Size.fromHeight(54),
      ),
      child: Image.asset(path, fit: BoxFit.cover),
    );
  }
}
