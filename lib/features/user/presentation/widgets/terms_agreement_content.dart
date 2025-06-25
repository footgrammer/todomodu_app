import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/user/presentation/pages/main/main_page.dart';
import 'package:todomodu_app/features/user/presentation/pages/terms_and_privacy_page.dart';
import 'package:todomodu_app/features/user/presentation/viewmodels/user_view_model.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';
import 'package:todomodu_app/shared/utils/navigate_to_page.dart';
import 'package:todomodu_app/shared/widgets/custom_icon.dart';

class TermsAgreementContent extends StatefulWidget {
  const TermsAgreementContent({super.key});

  @override
  State<TermsAgreementContent> createState() => _TermsAgreementContentState();
}

class _TermsAgreementContentState extends State<TermsAgreementContent> {
  bool allAgreed = false;
  List<bool> agreements = [false, false, false];

  void toggleAll(bool? value) {
    setState(() {
      allAgreed = value ?? false;
      agreements = List.generate(agreements.length, (_) => allAgreed);
    });
  }

  void toggleOne(int index, bool? value) {
    setState(() {
      agreements[index] = value ?? false;
      allAgreed = agreements.every((e) => e);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isButtonEnabled = agreements.every((e) => e);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                color: Colors.transparent,
                width: 24,
                height: 24,
                child: CustomIcon(name: 'close-md'),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '이용 약관 동의',
                style: AppTextStyles.header4.copyWith(color: AppColors.grey800),
              ),
            ),
            const SizedBox(height: 32),

            Row(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                    ),
                    child: Transform.scale(
                      scale: 1.33,
                      child: Checkbox(
                        value: allAgreed,
                        onChanged: (value) {
                          toggleAll(value);
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '모두 동의하기',
                  style: AppTextStyles.subtitle2.copyWith(
                    color: AppColors.grey700,
                  ),
                ),
              ],
            ),
            const Divider(height: 32, color: AppColors.grey200),

            ...List.generate(agreements.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                        ),
                        child: Transform.scale(
                          scale: 1.33,
                          child: Checkbox(
                            value: agreements[index],
                            onChanged: (value) {
                              toggleOne(index, value);
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '이용 약관 ${index + 1}', // 추후 수정
                      style: AppTextStyles.subtitle2.copyWith(
                        color: AppColors.grey700,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        navigateToPage(context, TermsAndPrivacyPage()); // 추후 수정
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: CustomIcon(
                          name: 'Chevron_Right_MD',
                          color: AppColors.grey400,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 24),

            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return ElevatedButton(
                  onPressed:
                      isButtonEnabled
                          ? () {
                            ref
                                .read(userViewModelProvider.notifier)
                                .fetchUser();
                            replaceAllWithPage(context, MainPage());
                          }
                          : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isButtonEnabled
                            ? AppColors.primary500
                            : AppColors.grey100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: Size.fromHeight(56),
                  ),
                  child: Text(
                    '계속 진행하기',
                    style: AppTextStyles.subtitle1.copyWith(
                      color: isButtonEnabled ? Colors.white : AppColors.grey400,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
