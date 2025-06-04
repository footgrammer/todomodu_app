import 'package:flutter/material.dart';

class ProgressView extends StatelessWidget {
  final double progress;

  const ProgressView({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '진척도', //진행도?
          style: TextStyle(color: Colors.black87),
        ),
        const SizedBox(
          height: 2,
        ),
        Row(
          children: [
            Text(
              '${(progress * 100).toInt()}%', //나중에 값이 어떻게 들어오느냐에 따라 식 바꿔주기
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 8,
            ),
            SizedBox(
              width: 60,
              height: 6,
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[300],
                color: Colors.black,
              ),
            )
          ],
        ),
      ],
    );
  }
}
