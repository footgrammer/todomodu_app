import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project/project_label.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

class ProjectDescriptionField extends ConsumerWidget {
  final TextEditingController descriptionController;
  final FocusNode descriptionFocusNode;

  const ProjectDescriptionField({
    super.key,
    required this.descriptionController,
    required this.descriptionFocusNode,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProjectLabel(text: '프로젝트 설명'),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          height: 260,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.grey50,
            border: Border.all(color: AppColors.grey200),
          ),
          child: TextFormField(
            controller: descriptionController,
            maxLines: null,
            focusNode: descriptionFocusNode,
            maxLength: 500,
            style: AppTextStyles.body2,
            decoration: InputDecoration(
              hintText: '''
할 일 목록 생성을 위해 프로젝트 설명을 적어주세요. 팀원 유무, 출력 수준도 함께 적어주시면 더 잘 도와드릴 수 있어요.
\n\n예: 다음 주 발표 준비 중이에요. 팀플이고, 간단하게 정리해줘도 괜찮아요.
''',
              hintMaxLines: 10,
              hintStyle: AppTextStyles.body2.copyWith(color: AppColors.grey400),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
