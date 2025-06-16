import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todomodu_app/features/user/data/datasources/user_data_source.dart';
import 'package:todomodu_app/features/user/domain/models/user_entity.dart';
import 'package:todomodu_app/features/user/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({required UserDataSource userDataSource})
    : _userDataSource = userDataSource;

  final UserDataSource _userDataSource;
  final userRef = FirebaseFirestore.instance.collection('users');

  @override
  Stream<UserEntity?> getCurrentUser() {
    return _userDataSource.getCurrentUser().map((userDto) {
      if (userDto == null) return null;
      return userDto.toEntity();
    });
  }

  @override
  Future<void> changeUserNickname(String userId, String nickname) async {
    await userRef.doc(userId).update({'name': nickname});
  }

  @override
  Future<void> uploadProfileImage(String userId) async {
    final picker = ImagePicker();
    final storage = FirebaseStorage.instance;

    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    File file = File(pickedFile!.path);

    try {
      final ref = storage.ref().child('profile_images/$userId');
      final uploadTask = await ref.putFile(file);
      final downloadUrl = await uploadTask.ref.getDownloadURL();
      await userRef.doc(userId).update({'profileImageUrl': downloadUrl});
    } catch (e) {
      log('파일 업로드 실패: $e');
    }
  }
}
