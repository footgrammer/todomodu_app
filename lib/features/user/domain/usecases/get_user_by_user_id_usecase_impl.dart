import 'package:todomodu_app/features/user/domain/models/user_entity.dart';
import 'package:todomodu_app/features/user/domain/repositories/user_repository.dart';
import 'package:todomodu_app/features/user/domain/usecases/get_user_by_user_id_usecase.dart';

class GetUserByUserIdUsecaseImpl implements GetUserByUserIdUsecase {
  GetUserByUserIdUsecaseImpl({required UserRepository userRepository})
    : _userRepository = userRepository;

  final UserRepository _userRepository;

  @override
  Stream<UserEntity?> execute(String userId) {
    return _userRepository.getUserByUserId(userId);
  }
}
