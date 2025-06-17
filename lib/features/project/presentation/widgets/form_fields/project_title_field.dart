import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project/project_label.dart';

class ProjectTitleField extends ConsumerWidget {
  TextEditingController titleController;
  FocusNode titleFocusNode;

  ProjectTitleField({
    super.key,
    required this.titleController,
    required this.titleFocusNode,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProjectLabel(text: '프로젝트 이름'),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xFFF7F7F8),
            border: Border.all(color: Color(0xFFDCDBE4)),
          ),
          child: TextFormField(
            controller: titleController,
            focusNode: titleFocusNode,
            maxLength: 30,
            style: TextStyle(fontSize: 16),
            decoration: InputDecoration(
              hintText: '프로젝트 이름을 입력하세요',
              hintStyle: TextStyle(color: Color(0xFFA7A5B9)),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
