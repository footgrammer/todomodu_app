import 'package:firebase_auth/firebase_auth.dart';
import 'package:todomodu_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<UserCredential?> signInWithCredential(
    OAuthCredential credential,
  ) async {
    return await _auth.signInWithCredential(credential);
  }
}
