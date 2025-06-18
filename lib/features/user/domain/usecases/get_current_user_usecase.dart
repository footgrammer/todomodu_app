
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';

abstract interface class GetCurrentUserUsecase {
  Stream<UserEntity?> execute();
}
