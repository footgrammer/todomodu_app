import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProjectSearchBar extends ConsumerWidget {
  TextEditingController controller;

  ProjectSearchBar({super.key, required this.controller});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Color.fromRGBO(0, 0, 0, 0.05),
      ),
      child: Row(
        children: [
          Icon(Icons.search, size: 24),
          SizedBox(width: 8),
          Expanded(
            child: TextFormField(
              controller: controller,
              style: TextStyle(fontSize: 16),
              decoration: InputDecoration(
                hintText: '프로젝트 코드를 입력하세요',
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
