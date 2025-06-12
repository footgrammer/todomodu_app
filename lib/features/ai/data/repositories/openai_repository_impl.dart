import 'package:todomodu_app/features/ai/data/datasources/openai_data_source.dart';
import 'package:todomodu_app/features/ai/data/models/openai_response_dto.dart';
import 'package:todomodu_app/features/ai/domain/models/openai_params.dart';
import 'package:todomodu_app/features/ai/domain/models/openai_response.dart';
import 'package:todomodu_app/features/ai/domain/repositories/openai_repository.dart';

class OpenaiRepositoryImpl implements OpenaiRepository {
  OpenaiRepositoryImpl({required OpenaiDataSource openaiDataSource})
    : _openaiDataSource = openaiDataSource;

  final OpenaiDataSource _openaiDataSource;

  @override
  Future<OpenaiResponse?> createProjectPlan(OpenaiParams openaiParams) async {
    final OpenaiResponseDto? openaiDto = await _openaiDataSource
        .fetchOpenaiResponse(openaiParams);
    if (openaiDto == null) return null;
    return openaiDto.toEntity();
  }
}
