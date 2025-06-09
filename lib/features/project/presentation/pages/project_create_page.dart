import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/project/presentation/widgets/form_fields/project_title_field.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project/project_label.dart';

final projectTitleControllerProvider =
    Provider.autoDispose<TextEditingController>(
      (ref) => TextEditingController(),
    );

class ProjectCreatePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 프로젝트 이름 컨트롤러
    final titleController = ref.watch(projectTitleControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              '프로젝트 추가하기',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ProjectTitleField(titleController: titleController)],
        ),
      ),
    );
  }
}
