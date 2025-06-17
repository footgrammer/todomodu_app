import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project/project_label.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

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
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.grey50,
            border: Border.all(color: AppColors.grey200),
          ),
          child: TextFormField(
            controller: titleController,
            focusNode: titleFocusNode,
            maxLength: 30,
            style: AppTextStyles.body2,
            decoration: InputDecoration(
              hintText: '프로젝트 이름을 입력하세요. (30자 이내)',
              hintStyle: AppTextStyles.body2.copyWith(color: AppColors.grey400),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              counterText: '', // 👈 이 줄 추가
            ),
          ),
        ),
      ],
    );
  }
}
