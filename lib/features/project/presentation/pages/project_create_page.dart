import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/project/presentation/widgets/form_fields/project_date_range_field.dart';
import 'package:todomodu_app/features/project/presentation/widgets/form_fields/project_title_field.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project/project_label.dart';

// 상태 관리용 Provider
final projectTitleControllerProvider =
    Provider.autoDispose<TextEditingController>(
      (ref) => TextEditingController(),
    );

final startDateProvider = StateProvider<DateTime?>((ref) => null);
final endDateProvider = StateProvider<DateTime?>((ref) => null);

class ProjectCreatePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 프로젝트 이름 컨트롤러
    final titleController = ref.watch(projectTitleControllerProvider);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // ✅ 현재 포커스 해제
      },
      child: Scaffold(
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProjectTitleField(titleController: titleController),
                SizedBox(height: 32),
                ProjectDateRangeField(
                  startDateProvider: startDateProvider,
                  endDateProvider: endDateProvider,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
