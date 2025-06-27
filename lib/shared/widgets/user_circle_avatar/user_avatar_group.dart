// 사용자 아바타 그룹을 겹쳐 표현하는 위젯

import 'package:flutter/material.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';
import 'package:todomodu_app/shared/widgets/user_circle_avatar/user_circle_avatar.dart';

class UserAvatarGroup extends StatelessWidget {
  final List<UserEntity> users;
  final double radius;

  // 화면에 아바타로 표시할 최대 사용자 수(기본값 5명), 초과치는 +n 표현
  final int maxVisibleCount;

  // 겹칠 간격
  final double overlapOffset;

  const UserAvatarGroup({
    super.key,
    required this.users,
    this.radius = 24.0,
    this.maxVisibleCount = 5,
    this.overlapOffset = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    final displayedUsers = users.take(maxVisibleCount).toList();
    
    // 표시 생략 인원 수 계산
    final hiddenCount = users.length > maxVisibleCount ? users.length - maxVisibleCount : 0;

    return SizedBox(
      width: radius * 2 + (displayedUsers.length + (hiddenCount > 0 ? 1 : 0) - 1) * overlapOffset,
      height: radius * 2,
      child: Stack(
        children: [
          for (int i = 0; i < displayedUsers.length; i++)
            Positioned(
              left: i * overlapOffset,
              child: UserCircleAvatar(user: displayedUsers[i], radius: radius),
            ),
          if (hiddenCount > 0)
            Positioned(
              left: displayedUsers.length * overlapOffset,
              child: CircleAvatar(
                radius: radius,
                backgroundColor: AppColors.primary100,
                child: Text(
                  '+$hiddenCount',
                  style: AppTextStyles.body3.copyWith(color: AppColors.grey800),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
