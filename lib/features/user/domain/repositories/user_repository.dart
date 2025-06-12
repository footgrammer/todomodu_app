import 'package:todomodu_app/features/user/domain/models/user_entity.dart';

abstract interface class UserRepository {
  Stream<UserEntity?> getCurrentUser();
  Future<void> changeUserNickname(String userId, String nickname);
  Future<void> uploadProfileImage(String userId);
}
