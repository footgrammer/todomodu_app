import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/shared/types/result.dart';

abstract interface class UserRepository {
  Stream<UserEntity?> getCurrentUser();
  Future<Result<List<UserEntity>>> getUsersByIds(List<String> ids);
  Stream<UserEntity?> getUserByUserId(String userId);
  Future<UserEntity?> getFutureUserByUserId(String userId);
  Future<void> changeUserNickname(String userId, String nickname);
  Future<void> uploadProfileImage(String userId);
  Future<Result<UserEntity>> getUserFutureById(String userId);
  Future<Result<UserEntity>> getCurrentUserFuture();
  Future<void> saveFcmToken(String userId, String token);
}
