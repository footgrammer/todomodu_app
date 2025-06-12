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
