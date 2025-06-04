import 'package:flutter/material.dart';

class NoticeCreateForm extends StatefulWidget {
  const NoticeCreateForm({super.key});

  @override
  State<NoticeCreateForm> createState() => _NoticeCreateFormState();
}

class _NoticeCreateFormState extends State<NoticeCreateForm> {

  final titleInputController = TextEditingController();
  final contentInputController = TextEditingController();
  
  @override
  void dispose() {
    titleInputController.dispose();
    contentInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('공지 제목',
              style: TextStyle(),
            ),
            TextFormField(
              controller: titleInputController,
              decoration: InputDecoration(
                hintText: '공지 제목을 입력하세요',
                border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 30,),
            Text('공지 내용',
              style: TextStyle(),
            ),
            TextFormField(
              controller: contentInputController,
              decoration: InputDecoration(
                hintText: '공지 내용을 입력하세요',
                border: OutlineInputBorder()
              ),
              maxLines: 5,
              maxLength: 500,
            ),
        ],),
      )
    );
  }
}
