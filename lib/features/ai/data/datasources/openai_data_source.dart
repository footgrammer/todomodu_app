import 'package:todomodu_app/features/ai/data/models/openai_response_dto.dart';

abstract interface class OpenaiDataSource {
  Future<OpenaiResponseDto?> fetchOpenaiResponse(String prompt);
}
