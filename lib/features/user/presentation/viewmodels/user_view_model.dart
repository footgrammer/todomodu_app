import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/features/user/domain/repositories/user_repository.dart';
import 'package:todomodu_app/features/user/domain/usecases/get_current_user_usecase_impl.dart';
import 'package:todomodu_app/features/user/domain/usecases/register_fcm_token_usecase.dart';
import 'package:todomodu_app/features/user/presentation/providers/user_providers.dart';

class UserViewModel extends StateNotifier<AsyncValue<UserEntity?>> {
  final GetCurrentUserUsecaseImpl fetchUserUsecase;
  final UserRepository userRepository;
  final RegisterFcmTokenUseCase registerFcmTokenUseCase;

   bool _fcmRegistered = false;

  UserViewModel({
    required this.fetchUserUsecase,
    required this.userRepository,
    required this.registerFcmTokenUseCase,
  }) : super(const AsyncValue.loading()) {
    fetchUser();
  }

  Future<UserEntity?> fetchUser() async {
    
    try {
      final user = await fetchUserUsecase.execute().first;
      log('_fcmRegistered: $_fcmRegistered');
      log('[UserViewModel] fetched user: $user');
      if (user != null && !_fcmRegistered) {
        log('fcm registered');
        await registerFcmTokenUseCase.execute(user.userId);
        _fcmRegistered = true;
        log('fcm registered');
      }
      state = AsyncValue.data(user);
      return user;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return null;
    }
  }

  Future<void> updateNickname(String userId, String newNickname) async {
    await userRepository.changeUserNickname(userId, newNickname);
    await fetchUser();
  }
}

final userViewModelProvider =
    StateNotifierProvider<UserViewModel, AsyncValue<UserEntity?>>((ref) {
      final fetchUserUsecase = ref.read(getCurrentUserUsecaseProvider);
      final userRepository = ref.read(userRepositoryProvider);
      final registerFcmTokenUseCase = ref.read(registerFcmTokenUseCaseProvider);
      return UserViewModel(
        fetchUserUsecase: fetchUserUsecase,
        userRepository: userRepository,
        registerFcmTokenUseCase: registerFcmTokenUseCase,
      );
    });
