import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/user/presentation/providers/user_providers.dart';
import 'package:todomodu_app/features/user/presentation/widgets/dual_action_buttons.dart';

class EditNicknameDialog extends StatefulWidget {
  const EditNicknameDialog({super.key, required this.userId});

  final String userId;
  @override
  State<EditNicknameDialog> createState() => _EditNicknameDialogState();
}

class _EditNicknameDialogState extends State<EditNicknameDialog> {
  final _nickNameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nickNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Dialog(
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '닉네임 수정하기',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                child: TextField(
                  controller: _nickNameController,
                  decoration: InputDecoration(
                    hintText: '닉네임을 입력해주세요.',
                    hintStyle: TextStyle(color: Color(0XFFCAC7DA)),
                    filled: true,
                    fillColor: Colors.grey[50],
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0XFFDCDBE4)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0XFF5752EA)),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                  ),
                ),
              ),
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  return DualActionButtons(
                    onCancel: () {
                      Navigator.pop(context);
                    },
                    onConfirm: () {
                      final userRepo = ref.read(userRepositoryProvider);
                      userRepo.changeUserNickname(
                        widget.userId,
                        _nickNameController.text.trim(),
                      );
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
