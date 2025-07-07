import 'package:cloud_firestore/cloud_firestore.dart';

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

  /// 알 수 없는 사용자용 정적 생성자
  factory UserEntity.unknown() {
    return UserEntity(
      userId: 'unknown',
      name: '알 수 없음',
      profileImageUrl: '',
      email: '',
      createdAt: DateTime(2000), // 오래된 기본값
    );
  }

  UserEntity.fromJson(Map<String, dynamic> map)
      : this(
          userId: map['userId'] ?? '',
          name: map['name'] ?? '',
          profileImageUrl: map['profileImageUrl'] ?? '',
          email: map['email'] ?? '',
          createdAt: map['createdAt'] != null
              ? (map['createdAt'] as Timestamp).toDate()
              : DateTime.now(),
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
