
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';

abstract interface class UserRepository {
  Stream<UserEntity?> getCurrentUser();
}
