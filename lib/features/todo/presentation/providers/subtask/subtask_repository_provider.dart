import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/todo/data/repositories/subtask_repository_impl.dart';
import 'package:todomodu_app/features/todo/domain/repositories/subtask_repository.dart';
import 'package:todomodu_app/features/todo/presentation/providers/subtask/subtask_datasource_provider.dart';

final subtaskRepositoryProvider = Provider<SubtaskRepository>((ref) {
  final dataSource = ref.watch(subtaskDatasourceProvider);
  return SubtaskRepositoryImpl(dataSource: dataSource);
});