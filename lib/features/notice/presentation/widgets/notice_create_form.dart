import 'package:flutter/material.dart';

class NoticeCreateForm extends StatefulWidget {
  const NoticeCreateForm({required this.onContentChanged, required this.onTitleChanged, super.key});
  final void Function(String) onTitleChanged;
  final void Function(String) onContentChanged;

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
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 7,),
            TextFormField(
              controller: titleInputController,
              onChanged: (value) {
                widget.onTitleChanged(value);
              },
              decoration: InputDecoration(
                hintText: '공지 제목을 입력하세요',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
              maxLines: 1,
              maxLength: 30,
            ),
            SizedBox(height: 20,),
            Text('공지 내용',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 7,),
            TextFormField(
              onChanged: (value) {
                widget.onContentChanged(value);
              },
              controller: contentInputController,
              decoration: InputDecoration(
                hintText: '공지 내용을 입력하세요',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
              maxLines: 5,
              maxLength: 500,
            ),
        ],),
      )
    );
  }
}
