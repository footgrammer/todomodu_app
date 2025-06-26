import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/user/data/datasources/auth_data_source.dart';
import 'package:todomodu_app/features/user/data/datasources/auth_data_source_impl.dart';
import 'package:todomodu_app/features/user/data/repositories/auth_repository_impl.dart';
import 'package:todomodu_app/features/user/domain/repositories/auth_repository.dart';

final authDataSourceProvider = Provider<AuthDataSource>((ref) {
  final firebaseAuth = FirebaseAuth.instance;
  return AuthDataSourceImpl(firebaseAuth: firebaseAuth);
});

final authProvider = Provider<AuthRepository>((ref) {
  final authDataSource = ref.watch(authDataSourceProvider);
  return AuthRepositoryImpl(authDataSource: authDataSource);
});
