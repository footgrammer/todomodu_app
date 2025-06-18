import 'package:todomodu_app/features/user/domain/models/user_entity.dart';

abstract interface class GetUserByUserIdUsecase {
  Stream<UserEntity?> execute(String userId);
}
