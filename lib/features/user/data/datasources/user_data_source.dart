import 'package:todomodu_app/features/user/data/models/user_dto.dart';

abstract interface class UserDataSource {
  Stream<UserDto?> getCurrentUser();
  Stream<UserDto?> getUserByUserId(String userId);
}
