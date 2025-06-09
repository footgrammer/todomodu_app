import 'package:todomodu_app/features/ai/domain/models/openai_response.dart';
import 'package:todomodu_app/features/ai/domain/repositories/openai_repository.dart';
import 'package:todomodu_app/features/ai/domain/usecases/fetch_openai_response_usecase.dart';

class FetchOpenaiResponseUsecaseImpl implements FetchOpenaiResponseUsecase {
  FetchOpenaiResponseUsecaseImpl({required OpenaiRepository openaiRepository})
    : _openaiRepository = openaiRepository;

  final OpenaiRepository _openaiRepository;
  @override
  Future<OpenaiResponse?> execute(String prompt) async {
    return _openaiRepository.fetchOpenaiResponse(prompt);
  }
}
