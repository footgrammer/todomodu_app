class UserEntity {
  final String userId;
  final String name;
  final String profileImageUrl;
  final String email;
  final DateTime createdAt;

  UserEntity({
    required this.userId,
    required this.name,
    required this.profileImageUrl,
    required this.email,
    required this.createdAt,
  });

  UserEntity.fromJson(Map<String, dynamic> map)
    : this(
        userId: map['userId'],
        name: map['name'],
        profileImageUrl: map['profileImageUrl'],
        email: map['email'],
        createdAt: map['createdAt'],
      );

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'profileImageUrl': profileImageUrl,
      'email': email,
      'createdAt': createdAt,
    };
  }
}
