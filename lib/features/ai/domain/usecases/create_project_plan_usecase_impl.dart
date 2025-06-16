import 'package:todomodu_app/features/ai/domain/models/openai_params.dart';
import 'package:todomodu_app/features/ai/domain/models/openai_response.dart';
import 'package:todomodu_app/features/ai/domain/repositories/openai_repository.dart';
import 'package:todomodu_app/features/ai/domain/usecases/create_project_plan_usecase.dart';

class FetchOpenaiResponseUsecaseImpl implements CreateProjectPlanUsecase {
  FetchOpenaiResponseUsecaseImpl({required OpenaiRepository openaiRepository})
    : _openaiRepository = openaiRepository;

  final OpenaiRepository _openaiRepository;
  @override
  Future<OpenaiResponse?> execute(OpenaiParams openaiParams) async {
    return _openaiRepository.createProjectPlan(openaiParams);
  }
}
