import 'package:todomodu_app/features/ai/data/models/openai_response_dto.dart';
import 'package:todomodu_app/features/ai/domain/models/openai_params.dart';

abstract interface class OpenaiDataSource {
  Future<OpenaiResponseDto?> fetchOpenaiResponse(OpenaiParams openaiParams);
}
