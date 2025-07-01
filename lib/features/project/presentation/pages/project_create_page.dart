import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/ai/domain/models/openai_params.dart';
import 'package:todomodu_app/features/ai/presentation/providers/openai_providers.dart';
import 'package:todomodu_app/features/project/presentation/pages/project_create_todo_page.dart';
import 'package:todomodu_app/features/project/presentation/pages/project_loading_page.dart';
import 'package:todomodu_app/features/project/presentation/providers/project_providers.dart';
import 'package:todomodu_app/features/project/presentation/utils/project_validator.dart';
import 'package:todomodu_app/features/project/presentation/viewmodels/project_loading_view_model.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project_create/project_form_field.dart';
import 'package:todomodu_app/features/user/presentation/pages/main/main_page.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';
import 'package:todomodu_app/shared/utils/dialog_utils.dart';
import 'package:todomodu_app/shared/utils/navigate_to_page.dart';
import 'package:todomodu_app/shared/widgets/common_elevated_button.dart';

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
          title: Row(
            children: [Text('프로젝트 추가하기', style: AppTextStyles.header2)],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: ProjectFormField(
                  titleController: titleController,
                  titleFocusNode: titleFocusNode,
                  descriptionController: descriptionController,
                  descriptionFocusNode: descriptionFocusNode,
                  startDateProvider: startDateProvider,
                  endDateProvider: endDateProvider,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 64,
                top: 10,
              ),
              child: CommonElevatedButton(
                buttonColor: AppColors.primary500,
                text: '프로젝트 추가하기',
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
  ) async {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();
    final startDate = ref.read(startDateProvider);
    final endDate = ref.read(endDateProvider);

    final titleError = ProjectValidator.validateTitle(title);
    final dateError = ProjectValidator.validateDates(startDate, endDate);
    final descriptionError = ProjectValidator.validateDescription(description);
    if (titleError != null) {
      DialogUtils.showErrorDialog(
        context,
        '프로젝트 이름을 입력해 주세요.',
        onDismiss: () {
          FocusScope.of(context).requestFocus(FocusNode());
          ref.read(titleFocusNodeProvider).requestFocus();
          titleController.selection = TextSelection.collapsed(offset: 0);
        },
      );
      return;
    }

    if (dateError != null) {
      DialogUtils.showErrorDialog(
        context,
        '시작일과 종료일을 선택해 주세요.',
        onDismiss: () {
          FocusScope.of(context).unfocus();
        },
      );
      return;
    }

    if (descriptionError != null) {
      DialogUtils.showErrorDialog(
        context,
        '프로젝트 설명을 입력해 주세요.',
        onDismiss: () {
          FocusScope.of(context).requestFocus(FocusNode());
          ref.read(descriptionFocusNodeProvider).requestFocus();
          descriptionController.selection = TextSelection.collapsed(offset: 0);
        },
      );
      return;
    }

    //상태값 저장해 놓기
    ref
        .read(projectCreateViewModelProvider.notifier)
        .updateProjectInfo(
          title: title,
          description: description,
          startDate: startDate!,
          endDate: endDate!,
        );

    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const ProjectLoadingPage()));

    final openaiParams = OpenaiParams(
      projectTitle: title,
      projectStartDate: startDate,
      projectEndDate: endDate,
      prompt: description,
    );
    try {
      final response = await ref.read(
        openaiResponseProvider(openaiParams).future,
      );
      response?.todos.map((todo) {}).toList();
      final progressViewModel = ref.read(projectProgressProvider.notifier);
      if (response != null) {
        final controller = ref.read(projectProgressProvider.notifier);
        await controller.completeRequest();
        await Future.delayed(Duration(seconds: 1));
        if (context.mounted) Navigator.of(context).pop();

        final viewModel = ref.read(projectCreateViewModelProvider.notifier);

        viewModel.selectAllTodos(response.todos);
        viewModel.selectAllSubtasks(response.todos);

        final state = ref.read(projectCreateViewModelProvider);
        viewModel.cacheInitialSubtasks(state.selectedSubtasks);

        if (context.mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ProjectCreateTodoPage(response: response),
            ),
          );
        }

        progressViewModel.reset();
      } else {
        progressViewModel.reset();
        if (context.mounted) {
          Navigator.of(context).pop();
          DialogUtils.showErrorDialog(
            context,
            'AI 응답이 비어있습니다.\n조금 더 구체적으로 프로젝트를 설명해 주세요!',
          );
          navigateToPage(context, MainPage());
        }
      }
    } catch (error) {
      log('Project_Create_page error : ${error}');

      if (context.mounted) navigateToPage(context, MainPage());
    }
  }
}
