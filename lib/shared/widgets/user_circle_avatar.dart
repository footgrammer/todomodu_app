import 'package:flutter/material.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

class UserCircleAvatar extends StatelessWidget {
  final UserEntity user;
  final double radius;

  const UserCircleAvatar({
    super.key,
    required this.user,
    this.radius = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: user.profileImageUrl.isNotEmpty
          ? NetworkImage(user.profileImageUrl)
          : null,
      child: user.profileImageUrl.isEmpty
          ? Text(
              user.name[0],
              style: AppTextStyles.header3.copyWith(color: AppColors.grey800),
            )
          : null,
    );
  }
}
