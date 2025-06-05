import 'package:flutter/material.dart';

class NoticeSearchbar extends StatefulWidget {
  const NoticeSearchbar({super.key});

  @override
  State<NoticeSearchbar> createState() => _NoticeSearchbarState();
}

class _NoticeSearchbarState extends State<NoticeSearchbar> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        suffixIcon: _controller.text.isNotEmpty ? IconButton(icon: Icon(Icons.clear), onPressed: () {
          _controller.clear();
        },) : null,
        hintText: '검색어를 입력하세요',
        border: OutlineInputBorder(
          
          borderRadius: BorderRadius.circular(12)
        )
      ),
    );
  }
}