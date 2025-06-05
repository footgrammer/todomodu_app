import 'package:todomodu_app/features/user/domain/models/user_entity.dart';
import 'package:todomodu_app/features/user/domain/repositories/user_repository.dart';
import 'package:todomodu_app/features/user/domain/usecases/get_current_user_usecase.dart';

class GetCurrentUserUsecaseImpl implements GetCurrentUserUsecase {
  GetCurrentUserUsecaseImpl({required UserRepository userRepository})
    : _userRepository = userRepository;

  final UserRepository _userRepository;

  @override
  Stream<UserEntity?> execute() {
    return _userRepository.getCurrentUser();
  }
}
