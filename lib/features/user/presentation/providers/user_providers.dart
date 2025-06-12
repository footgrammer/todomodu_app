import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/user/data/datasources/user_data_source.dart';
import 'package:todomodu_app/features/user/data/datasources/user_data_source_impl.dart';
import 'package:todomodu_app/features/user/data/repositories/user_repository_impl.dart';
import 'package:todomodu_app/features/user/domain/models/user_entity.dart';
import 'package:todomodu_app/features/user/domain/repositories/user_repository.dart';
import 'package:todomodu_app/features/user/domain/usecases/get_current_user_usecase_impl.dart';

final _userDataSourceProvider = Provider<UserDataSource>((ref) {
  return UserDataSourceImpl(
    firebaseAuth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  );
});

final _userRepositoryProvider = Provider<UserRepository>((ref) {
  final userDataSource = ref.read(_userDataSourceProvider);
  return UserRepositoryImpl(userDataSource: userDataSource);
});

final _getCurrentUserUsecaseProvider = Provider<GetCurrentUserUsecaseImpl>((
  ref,
) {
  final userRepository = ref.read(_userRepositoryProvider);
  return GetCurrentUserUsecaseImpl(userRepository: userRepository);
});

final userProvider = StreamProvider<UserEntity?>((ref) {
  final usecase = ref.read(_getCurrentUserUsecaseProvider);
  return usecase.execute();
});
