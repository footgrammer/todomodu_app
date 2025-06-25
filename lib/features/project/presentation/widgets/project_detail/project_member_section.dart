import 'package:flutter/material.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

class ProjectMemberSection extends StatelessWidget {
  final List<UserEntity> members;

  const ProjectMemberSection({super.key, required this.members});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('팀원', style: AppTextStyles.subtitle1.copyWith(color: AppColors.grey800)),
        const SizedBox(height: 8),
        Row(
          children: [
            for (var member in members)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CircleAvatar(
                  radius: 16,
                  backgroundImage: member.profileImageUrl.isNotEmpty
                      ? NetworkImage(member.profileImageUrl)
                      : null,
                  child: member.profileImageUrl.isEmpty
                      ? Text(member.name[0])
                      : null,
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
        ),
      ],
    );
  }
}
