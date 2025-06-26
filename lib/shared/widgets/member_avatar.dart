import 'package:flutter/material.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

class MemberAvatar extends StatelessWidget {
  final UserEntity member;
  final double radius;

  const MemberAvatar({
    super.key,
    required this.member,
    this.radius = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: member.profileImageUrl.isNotEmpty
          ? NetworkImage(member.profileImageUrl)
          : null,
      child: member.profileImageUrl.isEmpty
          ? Text(
              member.name[0],
              style: AppTextStyles.header3.copyWith(color: AppColors.grey800),
            )
          : null,
    );
  }
}
