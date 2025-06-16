
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/shared/types/result.dart';

abstract interface class UserRepository {
  Stream<UserEntity?> getCurrentUser();
  Future<Result<List<UserEntity>>> getUsersByIds(List<String> ids);
  Future<void> changeUserNickname(String userId, String nickname);
  Future<void> uploadProfileImage(String userId);
}
