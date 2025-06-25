import 'package:todomodu_app/features/user/data/models/user_dto.dart';
import 'package:todomodu_app/shared/types/result.dart';

abstract interface class UserDataSource {
  Stream<UserDto?> getCurrentUser();
  Future<Result<List<UserDto>>> getUsersByIds(List<String> ids);
  Stream<UserDto?> getUserByUserId(String userId);
  Future<UserDto?> getFutureUserByUserId(String userId);
}
