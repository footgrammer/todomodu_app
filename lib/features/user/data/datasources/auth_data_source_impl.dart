import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart';
import 'package:todomodu_app/features/auth/data/datasources/auth_data_source.dart';

class AuthDataSourceImpl implements AuthDataSource {
  AuthDataSourceImpl({required FirebaseAuth firebaseAuth})
    : _firebaseAuth = firebaseAuth;

  final FirebaseAuth _firebaseAuth;

  @override
  Future<OAuthCredential?> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return credential;
    } catch (e) {
      log('Google sign-in error: $e');
      return null;
    }
  }

  @override
  Future<OAuthCredential?> signInWithKakao() async {
    try {
      final isInstalled = await isKakaoTalkInstalled();
      final token =
          isInstalled
              ? await UserApi.instance.loginWithKakaoTalk()
              : await UserApi.instance.loginWithKakaoAccount();

      final credential = OAuthProvider(
        "oidc.kakao",
      ).credential(accessToken: token.accessToken, idToken: token.idToken);

      return credential;
    } catch (e, stack) {
      log('Kakao sign-in error: $e', stackTrace: stack);
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await GoogleSignIn().signOut();
    if (await AuthApi.instance.hasToken()) {
      await UserApi.instance.logout();
    }
  }
}
