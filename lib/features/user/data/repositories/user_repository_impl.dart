import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todomodu_app/features/user/data/datasources/user_data_source.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/features/user/domain/repositories/user_repository.dart';
import 'package:todomodu_app/shared/types/result.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({
    required UserDataSource userDataSource,
  }) : _userDataSource = userDataSource;

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
  Future<Result<List<UserEntity>>> getUsersByIds(List<String> ids) async {
    final result = await _userDataSource.getUsersByIds(ids);

    return switch (result) {
      Ok(value: final dtoList) => Result.ok(
        dtoList.map((dto) => dto.toEntity()).toList(),
      ),
      Error(:final error) => Result.error(error),
    };
  }

  @override
  Stream<UserEntity?> getUserByUserId(String userId) {
    return _userDataSource.getUserByUserId(userId).map((userDto) {
      if (userDto == null) return null;
      return userDto.toEntity();
    });
  }

  Future<UserEntity?> getFutureUserByUserId(String userId) async {
    final userDto = await _userDataSource.getFutureUserByUserId(userId);
    if (userDto == null) return null;
    return userDto.toEntity();
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

  @override
  Future<Result<UserEntity>> getUserFutureById(String userId) async {
    final result = await _userDataSource.getFutureUserResultByUserId(userId);

    return switch (result) {
      Ok(value: final dto) => Result.ok(dto.toEntity()),
      Error(:final error) => Result.error(error),
    };
  }

  @override
  Future<Result<UserEntity>> getCurrentUserFuture() async {
    final result = await _userDataSource.getCurrentUserFuture();

    return switch (result) {
      Ok(value: final dto) => Result.ok(dto.toEntity()),
      Error(:final error) => Result.error(error),
    };
  }

  @override
  Future<void> saveFcmToken(String userId, String token) {
    return _userDataSource.updateFcmToken(userId, token);
  }

}
