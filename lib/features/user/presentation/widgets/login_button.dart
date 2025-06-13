import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key, required this.path, required this.onPressed});

  final String path;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(padding: EdgeInsets.zero, elevation: 0),
      child: SvgPicture.asset(path),
    );
  }
}
