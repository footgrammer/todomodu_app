import 'package:flutter/material.dart';

class TodoTitleInput extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final String? errorText;

  const TodoTitleInput({
    super.key,
    required this.controller,
    this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('할 일 이름', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      TextField(
        controller: controller,
        onChanged: onChanged,
        maxLength: 30,
        decoration: InputDecoration(
          hintText: errorText ?? '할 일 제목을 입력하세요',
          hintStyle: TextStyle(color: errorText != null ? Colors.red : Colors.grey),
          errorText: null,
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true, fillColor: Colors.grey[300],
        ),
      ),
    ]);
  }
}