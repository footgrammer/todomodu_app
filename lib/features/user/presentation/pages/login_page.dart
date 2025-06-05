import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/user/providers/auth_providers.dart';
import 'package:todomodu_app/features/user/providers/user_providers.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.read(authProvider);
    final user = ref.watch(userProvider);

    return Scaffold(
      body: Center(
        child: user.when(
          loading: () => CircularProgressIndicator(),
          error: (error, stack) => Text('$error'),
          data: (user) {
            if (user != null) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(user.userId),
                  Text(user.name),
                  Text(user.profileImageUrl),
                  Text(user.email),
                  ElevatedButton(
                    onPressed: () async {
                      await auth.signOut();
                    },
                    child: Text('로그아웃'),
                  ),
                ],
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await auth.signInWithGoogle();
                    },
                    child: Text('구글 로그인'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await auth.signInWithKakao();
                    },
                    child: Text('카카오 로그인'),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
