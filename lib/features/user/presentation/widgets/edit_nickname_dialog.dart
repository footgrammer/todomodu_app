import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/user/presentation/viewmodels/user_view_model.dart';
import 'package:todomodu_app/features/user/presentation/widgets/dual_action_buttons.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

class EditNicknameDialog extends StatefulWidget {
  const EditNicknameDialog({super.key, required this.userId});

  final String userId;

  @override
  State<EditNicknameDialog> createState() => _EditNicknameDialogState();
}

class _EditNicknameDialogState extends State<EditNicknameDialog> {
  final TextEditingController _nickNameController = TextEditingController();

  @override
  void dispose() {
    _nickNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Center(
              child: Container(
                padding: const EdgeInsets.only(top: 32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '닉네임 수정하기',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.header4.copyWith(
                        color: AppColors.grey800,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: _nickNameController,
                        decoration: InputDecoration(
                          hintText: '닉네임을 입력해주세요',
                          hintStyle: AppTextStyles.body2.copyWith(
                            color: AppColors.grey400,
                          ),
                          filled: true,
                          fillColor: Colors.grey[50],
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: Color(0xFFDCDBE4),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: AppColors.primary500,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Consumer(
                      builder: (context, ref, child) {
                        return DualActionButtons(
                          onCancel: () => Navigator.pop(context),
                          onConfirm: () async {
                            final trimmed = _nickNameController.text.trim();
                            if (trimmed.isNotEmpty) {
                              await ref
                                  .read(userViewModelProvider.notifier)
                                  .updateNickname(widget.userId, trimmed);
                            }
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
