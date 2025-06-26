import 'package:flutter/material.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';
import 'package:todomodu_app/shared/widgets/user_circle_avatar.dart';

class ProjectMemberSection extends StatelessWidget {
  final List<UserEntity> members;

  const ProjectMemberSection({super.key, required this.members});

  @override
  Widget build(BuildContext context) {
    const double avatarRadius = 24;
    const double overlapOffset = 32;
    final displayedMembers = members.take(5).toList();
    final hiddenCount = members.length > 5 ? members.length - 5 : 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('팀원', style: AppTextStyles.subtitle1.copyWith(color: AppColors.grey800)),
        const SizedBox(height: 8),
        Row(
  children: [
    SizedBox(
      width:  avatarRadius * 2 + 5 * 16, // 최대 5개 겹침 + 여유
      height: avatarRadius * 2,
      child: Stack(
        children: [
          for (int i = 0; i < displayedMembers.length; i++)
            Positioned(
              left: i * overlapOffset,
              child: UserCircleAvatar(user: displayedMembers[i], radius: avatarRadius),
            ),
          if (hiddenCount > 0)
            Positioned(
              left: displayedMembers.length * overlapOffset,
              child: CircleAvatar(
                radius: avatarRadius,
                backgroundColor: AppColors.primary100,
                child: Text(
                  '+$hiddenCount',
                  style: AppTextStyles.body3.copyWith(color: AppColors.grey800,
                  ),
                ),
              ),
            ),
        ],
      ),
    ),
    const Spacer(),
    OutlinedButton.icon(
      onPressed: () {
        // 팀원 초대 동작 구현 필요
      },
      icon: Icon(Icons.add, color: AppColors.primary600),
      label: Text(
        '팀원 초대',
        style: AppTextStyles.subtitle3.copyWith(color: AppColors.primary600),
      ),
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColors.primary50,
        side: BorderSide(color: AppColors.primary600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        padding: const EdgeInsets.all(10),
      ),
    ),
  ],
)

      ],
    );
  }
}
