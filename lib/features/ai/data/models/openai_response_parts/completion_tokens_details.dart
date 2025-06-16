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
