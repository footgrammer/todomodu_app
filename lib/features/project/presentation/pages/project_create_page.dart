import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:todomodu_app/features/project/presentation/pages/project_loading_page.dart';
import 'package:todomodu_app/features/project/presentation/widgets/form_fields/project_date_range_field.dart';
import 'package:todomodu_app/features/project/presentation/widgets/form_fields/project_description_field.dart';
import 'package:todomodu_app/features/project/presentation/widgets/form_fields/project_title_field.dart';

TextStyle header2 = TextStyle(fontSize: 24, fontWeight: FontWeight.w600);

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

// 시작일, 종료일 provider
final startDateProvider = StateProvider.autoDispose<DateTime?>((ref) => null);
final endDateProvider = StateProvider.autoDispose<DateTime?>((ref) => null);

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
          title: Row(children: [Text('프로젝트 추가하기', style: header2)]),
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
    // Future<void> requestChatGPTApi = Future.delayed(Duration(seconds: 10));
    Future<Map<String, dynamic>> requestChatGPTApi(String prompt) async {
      await Future.delayed(Duration(seconds: 6));
      // final response = await http.post(
      //   Uri.parse("https://api.openai.com/v1/chat/completions"),
      //   headers: {
      //     "Authorization": "Bearer YOUR_API_KEY",
      //     "Content-Type": "application/json",
      //   },
      //   body: jsonEncode({
      //     "model": "gpt-4",
      //     "messages": [
      //       {"role": "user", "content": prompt},
      //     ],
      //   }),
      // );

      final data = {
        "projectTitle": "프로젝트 이름",
        "projectDescription": "프로젝트 설명",
        "projectStart_date": "2025-06-01",
        "projectEnd_date": "2025-06-30",
        "todos": [
          {
            "todoTitle": "여행 일정 계획 세우기",
            "todoStartDate": "2025-06-01",
            "todoEndDate": "2025-06-02",
            "subtasks": ["출발일 확정", "도시별 일정 조정"],
          },
          {
            "todoTitle": "항공권 예약하기",
            "todoStartDate": "2025-06-02",
            "todoEndDate": "2025-06-03",
            "subtasks": ["왕복 항공권 검색", "예약 완료 및 결제"],
          },
          {
            "todoTitle": "환전 준비하기",
            "todoStartDate": "2025-06-03",
            "todoEndDate": "2025-06-04",
            "subtasks": ["필요 금액 계산", "은행 또는 환전소 방문"],
          },
          {
            "todoTitle": "로밍 및 인터넷 준비하기",
            "todoStartDate": "2025-06-04",
            "todoEndDate": "2025-06-05",
            "subtasks": ["데이터 로밍 신청", "포켓 와이파이 또는 심카드 예약"],
          },
          {
            "todoTitle": "맛집/관광지 리스트 만들기",
            "todoStartDate": "2025-06-05",
            "todoEndDate": "2025-06-06",
            "subtasks": ["지역별 맛집 조사", "관광지 우선순위 정하기"],
          },
          {
            "todoTitle": "숙소 정하기",
            "todoStartDate": "2025-06-06",
            "todoEndDate": "2025-06-07",
            "subtasks": ["위치 비교", "예약 사이트 확인 및 결제"],
          },
          {
            "todoTitle": "집 꾸리기",
            "todoStartDate": "2025-06-07",
            "todoEndDate": "2025-06-08",
            "subtasks": ["청소하기", "반려식물 돌보기", "창문 닫기"],
          },
        ],
      };
      return data;
    }

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
