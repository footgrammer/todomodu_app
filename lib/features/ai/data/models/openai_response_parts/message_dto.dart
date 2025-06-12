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