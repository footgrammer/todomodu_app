import 'package:firebase_auth/firebase_auth.dart';
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
                  const Text('USERID'),
                  Text(user.userId),
                  const Text('NAME'),
                  Text(user.name),
                  const Text('URL'),
                  Text(user.profileImageUrl),
                  const Text('EMAIL'),
                  Text(user.email),
                  ElevatedButton(
                    onPressed: () async {
                      await auth.signOut();
                      ref.invalidate(userProvider);
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
