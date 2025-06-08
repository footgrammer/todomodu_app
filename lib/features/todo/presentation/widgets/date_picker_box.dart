import 'package:flutter/material.dart';

class DatePickerBox extends StatelessWidget {
  final DateTime date;
  final VoidCallback onTap;

  const DatePickerBox({
    required this.date,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String formatted =
        '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(formatted, style: TextStyle(fontSize: 16)),
            Icon(
              Icons.calendar_today_outlined,
              size: 18,
            )
          ],
        ),
      ),
    );
  }
}
