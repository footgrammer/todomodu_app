import 'package:todomodu_app/features/ai/domain/models/openai_response.dart';

abstract interface class OpenaiRepository {
  Future<OpenaiResponse?> fetchOpenaiResponse(String prompt);
}
