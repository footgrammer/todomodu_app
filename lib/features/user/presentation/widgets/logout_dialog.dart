import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/user/presentation/pages/login_page.dart';
import 'package:todomodu_app/features/user/presentation/providers/auth_providers.dart';
import 'package:todomodu_app/features/user/presentation/providers/user_providers.dart';
import 'package:todomodu_app/features/user/presentation/widgets/dual_action_buttons.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '로그아웃',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text('로그아웃 하시겠습니까?'),
            ),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return DualActionButtons(
                  onCancel: () {
                    Navigator.pop(context);
                  },
                  onConfirm: () async {
                    final authRepo = ref.read(authProvider);
                    await authRepo.signOut();
                    ref.invalidate(userProvider);
                    Navigator.of(context)
                      ..pop()
                      ..pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
