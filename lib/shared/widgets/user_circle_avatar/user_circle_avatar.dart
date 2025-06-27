// 단일 유저 아바타 사용 위젯

import 'package:flutter/material.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

class UserCircleAvatar extends StatelessWidget {
  final UserEntity user;
  final double radius;

  const UserCircleAvatar({super.key, required this.user, this.radius = 24.0});

  @override
  Widget build(BuildContext context) {
    final borderColor = Theme.of(context).scaffoldBackgroundColor;

    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 2),
      ),
      child: ClipOval(
        child: Container(
          color:
              user.profileImageUrl.isEmpty
                  ? AppColors.grey100
                  : null, // fallback bg
          child:
              user.profileImageUrl.isNotEmpty
                  ? Image.network(user.profileImageUrl, fit: BoxFit.cover)
                  : Center(
                    child: Icon(
                      Icons.person,
                      size: radius,
                      color: AppColors.grey400,
                    ),
                  ),
        ),
      ),
    );
  }
}
