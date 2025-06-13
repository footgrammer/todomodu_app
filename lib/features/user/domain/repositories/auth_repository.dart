import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthRepository {
  Future<UserCredential?> signInWithGoogle();
  Future<UserCredential?> signInWithKakao();
  Future<UserCredential?> signInWithApple();
  Future<void> signOut();
}
