
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/shared/types/result.dart';

abstract interface class GetCurrentUserFutureUsecase {
  Future<Result<UserEntity>> execute();
}
