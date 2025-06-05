import 'package:flutter/material.dart';

class AddTodoPage extends StatelessWidget {
  const AddTodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('할 일 추가하기'),
        centerTitle: false,
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('할 일 이름',
            style: TextStyle(fontSize: 16,
            fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(decoration: InputDecoration(
              hintText: '할 일 1',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              filled: true,
              fillColor: Colors.grey[150],
            ))
          ],
        ),),
    );
  }

}