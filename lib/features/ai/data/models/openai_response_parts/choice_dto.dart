import 'package:todomodu_app/features/ai/data/models/openai_response_parts/message_dto.dart';

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