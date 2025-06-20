import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/features/user/domain/usecases/get_current_user_usecase_impl.dart';
import 'package:todomodu_app/features/user/presentation/providers/user_providers.dart';

class UserViewModel extends StateNotifier<AsyncValue<UserEntity?>> {
  final GetCurrentUserUsecaseImpl _usecase;

  UserViewModel(this._usecase) : super(const AsyncValue.loading());

  Future<UserEntity?> fetchUser() async {
    try {
      final user = await _usecase.execute().first;
      log('fetchUser 성공: $user');
      state = AsyncValue.data(user);
      return user;
    } catch (e, st) {
      log('fetchUser 에러: $e');
      state = AsyncValue.error(e, st);
      return null;
    }
  }
}

final userViewModelProvider =
    StateNotifierProvider<UserViewModel, AsyncValue<UserEntity?>>((ref) {
      final usecase = ref.read(getCurrentUserUsecaseProvider);
      return UserViewModel(usecase);
    });
