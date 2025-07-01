import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/features/user/domain/repositories/user_repository.dart';
import 'package:todomodu_app/features/user/domain/usecases/get_current_user_future_usecase.dart';
import 'package:todomodu_app/shared/types/result.dart';

class GetCurrentUserFutureUsecaseImpl implements GetCurrentUserFutureUsecase {
  final UserRepository _userRepository;

  GetCurrentUserFutureUsecaseImpl({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  @override
  Future<Result<UserEntity>> execute() {
    return _userRepository.getCurrentUserFuture();
  }
}
