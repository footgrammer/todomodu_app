import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart' as kakao;
import 'package:todomodu_app/features/user/data/datasources/auth_data_source.dart';
import 'package:todomodu_app/features/user/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource;

  AuthRepositoryImpl({required AuthDataSource authDataSource})
    : _authDataSource = authDataSource;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential?> signInWithCredential(
    OAuthCredential? credential,
  ) async {
    if (credential == null) {
      return null;
    }
    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    return userCredential;
  }

  Future<void> createUserData(User user) async {
    final docRef = _firestore.collection('users').doc(user.uid);
    await docRef.set({
      'userId': user.uid,
      'email': user.email ?? '',
      'name': user.displayName ?? '',
      'profileImageUrl': user.photoURL ?? '',
    });
  }

  @override
  Future<UserCredential?> signInWithGoogle() async {
    final credential = await _authDataSource.signInWithGoogle();
    final userCredential = await signInWithCredential(credential);
    final user = userCredential?.user;
    if (user == null) return null;

    final userDoc = await _firestore.collection('users').doc(user.uid).get();
    if (!userDoc.exists) {
      createUserData(user);
    }
    return userCredential;
  }

  @override
  Future<UserCredential?> signInWithKakao() async {
    final credential = await _authDataSource.signInWithKakao();
    final userCredential = await signInWithCredential(credential);
    final user = userCredential?.user;
    if (user == null) return null;
    final profile = await kakao.TalkApi.instance.profile();
    await user.updateDisplayName(profile.nickname);
    await user.updatePhotoURL(profile.profileImageUrl);
    final userDoc = await _firestore.collection('users').doc(user.uid).get();
    if (!userDoc.exists) {
      createUserData(user);
    }
    return userCredential;
  }

  @override
  Future<UserCredential?> signInWithApple() async {
    final credential = await _authDataSource.signInWithApple();
    final userCredential = await signInWithCredential(credential);
    final user = userCredential?.user;
    if (user == null) return null;
    final userDoc = await _firestore.collection('users').doc(user.uid).get();
    if (!userDoc.exists) {
      createUserData(user);
    }
    return userCredential;
  }

  @override
  Future<void> signOut() {
    return _authDataSource.signOut();
  }
}
