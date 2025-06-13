import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/todo/data/repositories/todo_repository_impl.dart';
import 'package:todomodu_app/features/todo/presentation/providers/todo_remote_datasource_provider.dart';

final todoRepositoryProvider = Provider<TodoRepositoryImpl>((ref) {
  final remoteDataSource = ref.read(todoRemoteDataSourceProvider);
  return TodoRepositoryImpl(remoteDataSource);
});