import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/notification/data/datasources/fcm_data_source.dart';
import 'package:todomodu_app/features/notification/data/datasources/fcm_data_source_impl.dart';
import 'package:todomodu_app/features/user/data/datasources/user_data_source.dart';
import 'package:todomodu_app/features/user/data/datasources/user_data_source_impl.dart';
import 'package:todomodu_app/features/user/data/repositories/user_repository_impl.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/features/user/domain/repositories/user_repository.dart';
import 'package:todomodu_app/features/user/domain/usecases/get_current_user_future_usecase.dart';
import 'package:todomodu_app/features/user/domain/usecases/get_current_user_future_usecase_impl.dart';
import 'package:todomodu_app/features/user/domain/usecases/get_current_user_usecase_impl.dart';
import 'package:todomodu_app/features/user/domain/usecases/get_user_by_user_id_usecase.dart';
import 'package:todomodu_app/features/user/domain/usecases/get_user_by_user_id_usecase_impl.dart';
import 'package:todomodu_app/features/user/domain/usecases/register_fcm_token_usecase.dart';

final _userDataSourceProvider = Provider<UserDataSource>((ref) {
  return UserDataSourceImpl(
    firebaseAuth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  );
});

final _fcmDataSourceProvider = Provider<FcmDataSource>((ref) {
  return FcmDataSourceImpl(
    messaging : FirebaseMessaging.instance,
    firestore : FirebaseFirestore.instance,
  );
},);

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final userDataSource = ref.read(_userDataSourceProvider);
  return UserRepositoryImpl(userDataSource: userDataSource);
});

final getCurrentUserUsecaseProvider = Provider<GetCurrentUserUsecaseImpl>((
  ref,
) {
  final userRepository = ref.read(userRepositoryProvider);
  return GetCurrentUserUsecaseImpl(userRepository: userRepository);
});

final getUserByUserIdUsecaseProvider = Provider<GetUserByUserIdUsecase>((ref) {
  final repo = ref.watch(userRepositoryProvider);
  return GetUserByUserIdUsecaseImpl(userRepository: repo);
});

final userByUserIdProvider = StreamProvider.family<UserEntity?, String>((
  ref,
  userId,
) {
  final usecase = ref.watch(getUserByUserIdUsecaseProvider);
  return usecase.execute(userId);
});
final userProvider = StreamProvider<UserEntity?>((ref) {
  final usecase = ref.read(getCurrentUserUsecaseProvider);
  return usecase.execute();
});

final getCurrentUserFutureUsecaseProvider = Provider<GetCurrentUserFutureUsecase>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return GetCurrentUserFutureUsecaseImpl(userRepository: userRepository);
});

final registerFcmTokenUseCaseProvider = Provider<RegisterFcmTokenUseCase>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  final fcmDataSource = ref.read(_fcmDataSourceProvider);
  return RegisterFcmTokenUseCase(userRepository: userRepository, fcmDataSource: fcmDataSource);
});

