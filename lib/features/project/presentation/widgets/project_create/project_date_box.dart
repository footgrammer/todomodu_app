import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/shared/utils/date_utils.dart';

class ProjectDateBox extends ConsumerWidget {
  final DateTime? date;

  const ProjectDateBox(this.date, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 56,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFF7F7F8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFDCDBE4)),
      ),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: Text(
              formatDateYMD(date),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF403F4B),
              ),
            ),
          ),
          SizedBox(width: 4),
          Icon(Icons.calendar_month),
        ],
      ),
    );
  }
}
