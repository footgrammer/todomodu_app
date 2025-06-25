//Please delete this file
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/features/user/presentation/providers/user_providers.dart';
import 'package:todomodu_app/shared/constants/app_colors.dart';
import 'package:todomodu_app/shared/widgets/custom_icon.dart';

class MyProfileImage extends StatelessWidget {
  const MyProfileImage({super.key, required this.user});

  final UserEntity user;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        user.profileImageUrl.trim().isEmpty
            ? Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[400],
              ),
            )
            : Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(user.profileImageUrl, fit: BoxFit.cover),
              ),
            ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return GestureDetector(
                onTap: () {
                  log('카메라 버튼 클릭');
                  final userRepo = ref.read(userRepositoryProvider);
                  userRepo.uploadProfileImage(user.userId);
                },
                child: Container(
                  width: 28,
                  height: 28,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Color(0XFFF7F7F8)),
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                  ),
                  child: CustomIcon(
                    name: 'camera',
                    size: 16,
                    color: AppColors.grey500,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
