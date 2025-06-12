import 'package:cloud_firestore/cloud_firestore.dart';
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
}
