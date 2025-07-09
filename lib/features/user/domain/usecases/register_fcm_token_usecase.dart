import 'dart:developer';

import 'package:todomodu_app/features/notification/data/datasources/fcm_data_source.dart';
import 'package:todomodu_app/features/user/domain/repositories/user_repository.dart';

class RegisterFcmTokenUseCase {
  final FcmDataSource _fcmDataSource;
  final UserRepository _userRepository;

  RegisterFcmTokenUseCase({
    required FcmDataSource fcmDataSource,
    required UserRepository userRepository,
  }) : _fcmDataSource = fcmDataSource,
       _userRepository = userRepository;

  Future<void> execute(String userId) async {
    try {
      final token = await _fcmDataSource.getToken();
      log('token : $token');
      if (token != null) {
        await _userRepository.saveFcmToken(userId, token);
      }

      _fcmDataSource.listenTokenRefresh(userId);
      log('fcm 토큰 등록됨');
    } catch (e, st) {
      log('🔥 FCM 등록 실패: $e', stackTrace: st);
    }
  }
}
