import 'package:todomodu_app/features/user/data/datasources/user_data_source.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/features/user/domain/repositories/user_repository.dart';
import 'package:todomodu_app/shared/types/result.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({required UserDataSource userDataSource})
    : _userDataSource = userDataSource;

  final UserDataSource _userDataSource;
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

}
