import 'package:todomodu_app/features/user/data/datasources/user_data_source.dart';
import 'package:todomodu_app/features/user/domain/models/user_entity.dart';
import 'package:todomodu_app/features/user/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({required UserDataSource userDataSource})
    : _userDataSource = userDataSource;

  final UserDataSource _userDataSource;
  @override
  Stream<UserEntity?> getCurrentUser() {
    return _userDataSource.getCurrentUser().map((userDto) {
      if (userDto == null) return null;
      return UserEntity(
        userId: userDto.userId,
        name: userDto.name,
        profileImageUrl: userDto.profileImageUrl,
        email: userDto.email,
      );
    });
  }
}
