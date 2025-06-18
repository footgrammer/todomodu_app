import 'package:flutter/material.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';

class UserProfileImage extends StatelessWidget {
  final UserEntity user;
  final double size;

  const UserProfileImage({
    super.key,
    required this.user,
    this.size = 100,
  });

  @override
  Widget build(BuildContext context) {
    final isEmpty = user.profileImageUrl.trim().isEmpty;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isEmpty ? Colors.grey[400] : null,
      ),
      child: isEmpty
          ? null
          : ClipRRect(
              borderRadius: BorderRadius.circular(size),
              child: Image.network(
                user.profileImageUrl,
                fit: BoxFit.cover,
              ),
            ),
    );
  }
}
