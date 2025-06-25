import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/features/user/domain/repositories/user_repository.dart';
import 'package:todomodu_app/features/user/domain/usecases/get_current_user_usecase_impl.dart';
import 'package:todomodu_app/features/user/presentation/providers/user_providers.dart';

class UserViewModel extends StateNotifier<AsyncValue<UserEntity?>> {
  final GetCurrentUserUsecaseImpl _usecase;
  final UserRepository _userRepository;

  UserViewModel(this._usecase, this._userRepository)
    : super(const AsyncValue.loading()) {
    fetchUser();
  }

  Future<UserEntity?> fetchUser() async {
    try {
      final user = await _usecase.execute().first;
      log('fetchUser 성공: ${user!.userId}');
      state = AsyncValue.data(user);
      return user;
    } catch (e, st) {
      log('fetchUser 에러: $e');
      state = AsyncValue.error(e, st);
      return null;
    }
  }

  Future<void> updateNickname(String userId, String newNickname) async {
    await _userRepository.changeUserNickname(userId, newNickname);
    await fetchUser();
  }
}

final userViewModelProvider =
    StateNotifierProvider.autoDispose<UserViewModel, AsyncValue<UserEntity?>>((
      ref,
    ) {
      final usecase = ref.read(getCurrentUserUsecaseProvider);
      final userRepository = ref.read(userRepositoryProvider);
      return UserViewModel(usecase, userRepository);
    });
