import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:todomodu_app/features/user/data/datasources/auth_data_source.dart';

class AuthDataSourceImpl implements AuthDataSource {
  AuthDataSourceImpl({required FirebaseAuth firebaseAuth})
    : _firebaseAuth = firebaseAuth;

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final SignInWithApple appleSignIn = SignInWithApple();

  @override
  Future<OAuthCredential?> signInWithGoogle() async {
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
  Future<OAuthCredential?> signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final OAuthCredential authCredential = OAuthProvider(
        "apple.com",
      ).credential(
        idToken: credential.identityToken,
        accessToken: credential.authorizationCode,
      );
      return authCredential;
    } catch (e) {
      log('Apple sign-in error: $e');
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await googleSignIn.signOut();
    if (await AuthApi.instance.hasToken()) {
      await UserApi.instance.logout();
    }
  }
}
