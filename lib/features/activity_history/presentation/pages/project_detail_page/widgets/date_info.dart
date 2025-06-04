import 'package:flutter/material.dart';

class DateInfo extends StatelessWidget {
  final String label;
  final String date;

  const DateInfo({super.key, required this.label, required this.date});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
        style: TextStyle(color: Colors.black87)),
        const SizedBox(height: 2),
        Text(date,
        style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
