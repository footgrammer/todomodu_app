import 'package:todomodu_app/features/ai/domain/models/openai_response.dart';

abstract interface class FetchOpenaiResponseUsecase {
  Future<OpenaiResponse?> execute(String prompt);
}
