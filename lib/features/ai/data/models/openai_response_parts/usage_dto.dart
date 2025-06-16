import 'package:todomodu_app/features/ai/data/models/openai_response_parts/completion_tokens_details.dart';
import 'package:todomodu_app/features/ai/data/models/openai_response_parts/prompt_tokens_details_dto.dart';

class Usage {
  final int promptTokens;
  final int completionTokens;
  final int totalTokens;
  final PromptTokensDetails promptTokensDetails;
  final CompletionTokensDetails completionTokensDetails;

  Usage({
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
    required this.promptTokensDetails,
    required this.completionTokensDetails,
  });

  Usage copyWith({
    int? promptTokens,
    int? completionTokens,
    int? totalTokens,
    PromptTokensDetails? promptTokensDetails,
    CompletionTokensDetails? completionTokensDetails,
  }) => Usage(
    promptTokens: promptTokens ?? this.promptTokens,
    completionTokens: completionTokens ?? this.completionTokens,
    totalTokens: totalTokens ?? this.totalTokens,
    promptTokensDetails: promptTokensDetails ?? this.promptTokensDetails,
    completionTokensDetails:
        completionTokensDetails ?? this.completionTokensDetails,
  );

  factory Usage.fromJson(Map<String, dynamic> json) => Usage(
    promptTokens: json["prompt_tokens"],
    completionTokens: json["completion_tokens"],
    totalTokens: json["total_tokens"],
    promptTokensDetails: PromptTokensDetails.fromJson(
      json["prompt_tokens_details"],
    ),
    completionTokensDetails: CompletionTokensDetails.fromJson(
      json["completion_tokens_details"],
    ),
  );

  Map<String, dynamic> toJson() => {
    "prompt_tokens": promptTokens,
    "completion_tokens": completionTokens,
    "total_tokens": totalTokens,
    "prompt_tokens_details": promptTokensDetails.toJson(),
    "completion_tokens_details": completionTokensDetails.toJson(),
  };
}