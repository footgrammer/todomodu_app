import 'package:todomodu_app/features/ai/domain/models/openai_params.dart';
import 'package:todomodu_app/features/ai/domain/models/openai_response.dart';

abstract interface class OpenaiRepository {
  Future<OpenaiResponse?> fetchOpenaiResponse(OpenaiParams openaiParams);
}
