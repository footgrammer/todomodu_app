import 'package:todomodu_app/features/ai/data/datasources/openai_data_source.dart';
import 'package:todomodu_app/features/ai/data/models/openai_response_dto.dart';
import 'package:todomodu_app/features/ai/domain/models/openai_response.dart';
import 'package:todomodu_app/features/ai/domain/repositories/openai_repository.dart';

class OpenaiRepositoryImpl implements OpenaiRepository {
  OpenaiRepositoryImpl({required OpenaiDataSource openaiDataSource})
    : _openaiDataSource = openaiDataSource;

  final OpenaiDataSource _openaiDataSource;

  @override
  Future<OpenaiResponse?> fetchOpenaiResponse(String prompt) async {
    final List<OpenaiResponseDto>? openaiDto = await _openaiDataSource
        .fetchOpenaiResponse(prompt);
    if (openaiDto == null) return null;
    return openaiDto.first.toEntity();
  }
}
