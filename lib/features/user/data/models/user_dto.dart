import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';

class UserDto {
  final String userId;
  final String name;
  final String profileImageUrl;
  final String email;
  final DateTime createdAt;

  UserDto({
    required this.userId,
    required this.name,
    required this.profileImageUrl,
    required this.email,
    required this.createdAt,
  });

  UserDto.fromJson(Map<String, dynamic> map)
    : this(
        userId: map['userId'] ?? '',
        name: map['name'] ?? '',
        profileImageUrl: map['profileImageUrl'] ?? '',
        email: map['email'] ?? '',
        createdAt:
            map['createdAt'] != null
                ? (map['createdAt'] as Timestamp).toDate()
                : DateTime.now(), // 기본값 설정
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

  UserEntity toEntity() {
    return UserEntity(
      userId: userId,
      name: name,
      profileImageUrl: profileImageUrl,
      email: email,
      createdAt: createdAt,
    );
  }

  factory UserDto.fromEntity(UserEntity entity) {
    return UserDto(
      userId: entity.userId,
      name: entity.name,
      profileImageUrl: entity.profileImageUrl,
      email: entity.email,
      createdAt: entity.createdAt,
    );
  }
}
