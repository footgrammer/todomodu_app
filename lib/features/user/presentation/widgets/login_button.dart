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
      child: Row(
        children: [
          SizedBox.square(
            dimension: 24,
            child: Image.asset(path, fit: BoxFit.cover),
          ),
          Text(
            '로 로그인하기',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
