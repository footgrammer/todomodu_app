import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/project/presentation/pages/project_loading_page.dart';
import 'package:todomodu_app/features/project/presentation/widgets/form_fields/project_date_range_field.dart';
import 'package:todomodu_app/features/project/presentation/widgets/form_fields/project_description_field.dart';
import 'package:todomodu_app/features/project/presentation/widgets/form_fields/project_title_field.dart';

// 상태 관리용 Provider
final titleControllerProvider = Provider.autoDispose<TextEditingController>(
  (ref) => TextEditingController(),
);

final descriptionControllerProvider =
    Provider.autoDispose<TextEditingController>(
      (ref) => TextEditingController(),
    );

// FocusNode용 Provider
final titleFocusNodeProvider = Provider.autoDispose<FocusNode>(
  (ref) => FocusNode(),
);

final descriptionFocusNodeProvider = Provider.autoDispose<FocusNode>(
  (ref) => FocusNode(),
);

final startDateProvider = StateProvider<DateTime?>((ref) => null);
final endDateProvider = StateProvider<DateTime?>((ref) => null);

class ProjectCreatePage extends ConsumerWidget {
  const ProjectCreatePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 텍스트 컨트롤러
    final titleController = ref.watch(titleControllerProvider);
    final descriptionController = ref.watch(descriptionControllerProvider);

    // focusNode
    final titleFocusNode = ref.watch(titleFocusNodeProvider);
    final descriptionFocusNode = ref.watch(descriptionFocusNodeProvider);

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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProjectTitleField(
                      titleController: titleController,
                      titleFocusNode: titleFocusNode,
                    ),
                    SizedBox(height: 32),
                    ProjectDateRangeField(
                      startDateProvider: startDateProvider,
                      endDateProvider: endDateProvider,
                    ),
                    SizedBox(height: 32),
                    ProjectDescriptionField(
                      descriptionController: descriptionController,
                      descriptionFocusNode: descriptionFocusNode,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 40,
                top: 10,
              ),
              child: ElevatedButton(
                onPressed: () {
                  _validateAndProceed(
                    context,
                    ref,
                    titleController,
                    descriptionController,
                    titleFocusNodeProvider,
                    descriptionFocusNodeProvider,
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 56),
                  backgroundColor: Color(0xFF5752EA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  '프로젝트 추가하기',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _validateAndProceed(
    BuildContext context,
    WidgetRef ref,
    TextEditingController titleController,
    TextEditingController descriptionController,
    AutoDisposeProvider<FocusNode> titleFocusNodeProvider,
    AutoDisposeProvider<FocusNode> descriptionFocusNodeProvider,
  ) {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();
    final startDate = ref.read(startDateProvider);
    final endDate = ref.read(endDateProvider);

    if (title.isEmpty) {
      _showErrorDialog(context, '프로젝트 이름을 입력해 주세요.', () {
        FocusScope.of(context).requestFocus(FocusNode());
        ref.read(titleFocusNodeProvider).requestFocus();
        titleController.selection = TextSelection.collapsed(offset: 0);
      });
      return;
    }

    if (startDate == null || endDate == null) {
      _showErrorDialog(context, '시작일과 종료일을 선택해 주세요.', () {
        FocusScope.of(context).unfocus();
      });
      return;
    }

    if (description.isEmpty) {
      _showErrorDialog(context, '프로젝트 설명을 입력해 주세요.', () {
        FocusScope.of(context).requestFocus(FocusNode());
        ref.read(descriptionFocusNodeProvider).requestFocus();
        descriptionController.selection = TextSelection.collapsed(offset: 0);
      });
      return;
    }

    // chat GPT API 함수
    Future<void> requestChatGPTApi = Future.delayed(Duration(seconds: 10));

    // 모든 검증 통과 시 수행할 로직 추가
    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (_) => ProjectLoadingPage(requestChatGPTApi: requestChatGPTApi),
      ),
    );
  }

  void _showErrorDialog(
    BuildContext context,
    String message,
    VoidCallback onDismiss,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('알림'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onDismiss();
                },
                child: Text('확인'),
              ),
            ],
          ),
    );
  }
}
