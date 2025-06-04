import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthRepository {
  Future<UserCredential?> signInWithCredential(OAuthCredential credential);
}
