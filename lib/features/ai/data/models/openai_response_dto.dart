// To parse this JSON data, do
//
//     final openaiDto = openaiDtoFromJson(jsonString);

import 'dart:convert';

import 'package:todomodu_app/features/ai/domain/models/openai_response.dart';

OpenaiResponseDto openaiResponseDtoFromJson(String str) =>
    OpenaiResponseDto.fromJson(json.decode(str));

String openaiResponseDtoToJson(OpenaiResponseDto data) =>
    json.encode(data.toJson());

class OpenaiResponseDto {
  final String id;
  final String object;
  final int created;
  final String model;
  final List<Choice> choices;
  final Usage usage;
  final String serviceTier;
  final dynamic systemFingerprint;

  OpenaiResponseDto({
    required this.id,
    required this.object,
    required this.created,
    required this.model,
    required this.choices,
    required this.usage,
    required this.serviceTier,
    required this.systemFingerprint,
  });

  OpenaiResponseDto copyWith({
    String? id,
    String? object,
    int? created,
    String? model,
    List<Choice>? choices,
    Usage? usage,
    String? serviceTier,
    dynamic systemFingerprint,
  }) => OpenaiResponseDto(
    id: id ?? this.id,
    object: object ?? this.object,
    created: created ?? this.created,
    model: model ?? this.model,
    choices: choices ?? this.choices,
    usage: usage ?? this.usage,
    serviceTier: serviceTier ?? this.serviceTier,
    systemFingerprint: systemFingerprint ?? this.systemFingerprint,
  );

  factory OpenaiResponseDto.fromJson(Map<String, dynamic> json) =>
      OpenaiResponseDto(
        id: json["id"],
        object: json["object"],
        created: json["created"],
        model: json["model"],
        choices: List<Choice>.from(
          json["choices"].map((x) => Choice.fromJson(x)),
        ),
        usage: Usage.fromJson(json["usage"]),
        serviceTier: json["service_tier"],
        systemFingerprint: json["system_fingerprint"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "object": object,
    "created": created,
    "model": model,
    "choices": List<dynamic>.from(choices.map((x) => x.toJson())),
    "usage": usage.toJson(),
    "service_tier": serviceTier,
    "system_fingerprint": systemFingerprint,
  };

  OpenaiResponse toEntity() {
    final content = choices.first.message.content;

    final Map<String, dynamic> jsonData = json.decode(content);

    return OpenaiResponse(
      projectTitle: jsonData['project_title'],
      projectDescription: jsonData['project_description'],
      projectStartDate: jsonData['project_start_date'],
      projectEndDate: jsonData['project_end_date'],
      todos:
          (jsonData['todos'] as List)
              .map(
                (todoJson) => Todo(
                  todoTitle: todoJson['todo_title'],
                  todoStartDate: todoJson['todo_start_date'],
                  todoEndDate: todoJson['todo_end_date'],
                  subTasks: List<String>.from(todoJson['sub_tasks']),
                ),
              )
              .toList(),
    );
  }
}

class Choice {
  final int index;
  final Message message;
  final dynamic logprobs;
  final String finishReason;

  Choice({
    required this.index,
    required this.message,
    required this.logprobs,
    required this.finishReason,
  });

  Choice copyWith({
    int? index,
    Message? message,
    dynamic logprobs,
    String? finishReason,
  }) => Choice(
    index: index ?? this.index,
    message: message ?? this.message,
    logprobs: logprobs ?? this.logprobs,
    finishReason: finishReason ?? this.finishReason,
  );

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
    index: json["index"],
    message: Message.fromJson(json["message"]),
    logprobs: json["logprobs"],
    finishReason: json["finish_reason"],
  );

  Map<String, dynamic> toJson() => {
    "index": index,
    "message": message.toJson(),
    "logprobs": logprobs,
    "finish_reason": finishReason,
  };
}

class Message {
  final String role;
  final String content;
  final dynamic refusal;
  final List<dynamic> annotations;

  Message({
    required this.role,
    required this.content,
    required this.refusal,
    required this.annotations,
  });

  Message copyWith({
    String? role,
    String? content,
    dynamic refusal,
    List<dynamic>? annotations,
  }) => Message(
    role: role ?? this.role,
    content: content ?? this.content,
    refusal: refusal ?? this.refusal,
    annotations: annotations ?? this.annotations,
  );

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    role: json["role"],
    content: json["content"],
    refusal: json["refusal"],
    annotations: List<dynamic>.from(json["annotations"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "role": role,
    "content": content,
    "refusal": refusal,
    "annotations": List<dynamic>.from(annotations.map((x) => x)),
  };
}

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

class CompletionTokensDetails {
  final int reasoningTokens;
  final int audioTokens;
  final int acceptedPredictionTokens;
  final int rejectedPredictionTokens;

  CompletionTokensDetails({
    required this.reasoningTokens,
    required this.audioTokens,
    required this.acceptedPredictionTokens,
    required this.rejectedPredictionTokens,
  });

  CompletionTokensDetails copyWith({
    int? reasoningTokens,
    int? audioTokens,
    int? acceptedPredictionTokens,
    int? rejectedPredictionTokens,
  }) => CompletionTokensDetails(
    reasoningTokens: reasoningTokens ?? this.reasoningTokens,
    audioTokens: audioTokens ?? this.audioTokens,
    acceptedPredictionTokens:
        acceptedPredictionTokens ?? this.acceptedPredictionTokens,
    rejectedPredictionTokens:
        rejectedPredictionTokens ?? this.rejectedPredictionTokens,
  );

  factory CompletionTokensDetails.fromJson(Map<String, dynamic> json) =>
      CompletionTokensDetails(
        reasoningTokens: json["reasoning_tokens"],
        audioTokens: json["audio_tokens"],
        acceptedPredictionTokens: json["accepted_prediction_tokens"],
        rejectedPredictionTokens: json["rejected_prediction_tokens"],
      );

  Map<String, dynamic> toJson() => {
    "reasoning_tokens": reasoningTokens,
    "audio_tokens": audioTokens,
    "accepted_prediction_tokens": acceptedPredictionTokens,
    "rejected_prediction_tokens": rejectedPredictionTokens,
  };
}

class PromptTokensDetails {
  final int cachedTokens;
  final int audioTokens;

  PromptTokensDetails({required this.cachedTokens, required this.audioTokens});

  PromptTokensDetails copyWith({int? cachedTokens, int? audioTokens}) =>
      PromptTokensDetails(
        cachedTokens: cachedTokens ?? this.cachedTokens,
        audioTokens: audioTokens ?? this.audioTokens,
      );

  factory PromptTokensDetails.fromJson(Map<String, dynamic> json) =>
      PromptTokensDetails(
        cachedTokens: json["cached_tokens"],
        audioTokens: json["audio_tokens"],
      );

  Map<String, dynamic> toJson() => {
    "cached_tokens": cachedTokens,
    "audio_tokens": audioTokens,
  };
}
