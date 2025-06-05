class UserDto {
  final String userId;
  final String name;
  final String profileImageUrl;
  final String email;

  UserDto({
    required this.userId,
    required this.name,
    required this.profileImageUrl,
    required this.email,
  });

  UserDto.fromJson(Map<String, dynamic> map)
    : this(
        userId: map['userId'],
        name: map['name'],
        profileImageUrl: map['profileImageUrl'],
        email: map['email'],
      );

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'profileImageUrl': profileImageUrl,
      'email': email,
    };
  }
}
