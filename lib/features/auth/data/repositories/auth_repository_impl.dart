import 'package:firebase_auth/firebase_auth.dart';
import 'package:todomodu_app/features/auth/data/datasources/auth_data_source.dart';
import 'package:todomodu_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource;

  AuthRepositoryImpl({required AuthDataSource authDataSource})
    : _authDataSource = authDataSource;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential?> signInWithCredential(
    OAuthCredential? credential,
  ) async {
    if (credential == null) {
      return null;
    }
    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    return userCredential;
  }

  @override
  Future<UserCredential?> signInWithGoogle() async {
    final credential = await _authDataSource.signInWithGoogle();
    final userCredential = signInWithCredential(credential);
    return userCredential;
  }

  @override
  Future<UserCredential?> signInWithKakao() async {
    final credential = await _authDataSource.signInWithKakao();
    final userCredential = signInWithCredential(credential);
    return userCredential;
  }

  @override
  Future<void> signOut() {
    return _authDataSource.signOut();
  }
}
