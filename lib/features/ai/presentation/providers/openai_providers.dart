import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/ai/data/datasources/openai_data_source.dart';
import 'package:todomodu_app/features/ai/data/datasources/openai_data_source_impl.dart';
import 'package:todomodu_app/features/ai/data/repositories/openai_repository_impl.dart';
import 'package:todomodu_app/features/ai/domain/models/openai_params.dart';
import 'package:todomodu_app/features/ai/domain/models/openai_response.dart';
import 'package:todomodu_app/features/ai/domain/repositories/openai_repository.dart';
import 'package:todomodu_app/features/ai/domain/usecases/fetch_openai_response_usecase.dart';
import 'package:todomodu_app/features/ai/domain/usecases/fetch_openai_response_usecase_impl.dart';

final _openaiDataSourceProvider = Provider<OpenaiDataSource>((ref) {
  return OpenaiDataSourceImpl(dio: Dio());
});

final _openaiRepositoryProvider = Provider<OpenaiRepository>((ref) {
  final openaiDataSource = ref.read(_openaiDataSourceProvider);
  return OpenaiRepositoryImpl(openaiDataSource: openaiDataSource);
});

final _openaiUsercaseProvider = Provider<FetchOpenaiResponseUsecase>((ref) {
  final openaiRepository = ref.read(_openaiRepositoryProvider);
  return FetchOpenaiResponseUsecaseImpl(openaiRepository: openaiRepository);
});

final openaiResponseProvider = FutureProvider.autoDispose
    .family<OpenaiResponse?, OpenaiParams>((ref, params) async {
      final openaiUsecase = ref.read(_openaiUsercaseProvider);
      return await openaiUsecase.execute(params);
    });
