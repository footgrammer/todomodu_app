import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/project/data/models/Project.dart';

class ProjectProgressBar extends ConsumerWidget {
  Color textColor;
  Project project;

  ProjectProgressBar({
    super.key,
    required this.textColor,
    required this.project,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('진척도', style: TextStyle(color: textColor, fontSize: 14)),
            Text(
              '74%',
              style: TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),

        SizedBox(
          width: double.infinity,
          child: LinearProgressIndicator(
            value: 0.74,
            minHeight: 10,
            color: Color(0xFF585666),
            backgroundColor: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }
}
