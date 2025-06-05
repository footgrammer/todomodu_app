class UserEntity {
  String id;
  String name;
  String profileImageUrl;
  String email;
  DateTime createdAt;

  UserEntity({
    required this.id,
    required this.name,
    required this.profileImageUrl,
    required this.email,
    required this.createdAt,
  });
}