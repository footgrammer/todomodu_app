import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthDataSource {
  Future<OAuthCredential?> signInWithGoogle();
  Future<OAuthCredential?> signInWithKakao();
  Future<void> signOut();
}
