//Please delete this file
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:todomodu_app/shared/widgets/custom_icon.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key, required this.profileImageUrl});

  final String profileImageUrl;
  @override
  Widget build(BuildContext context) {
    return profileImageUrl.trim().isEmpty
        ? Stack(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[400],
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: () {
                  log('카메라 버튼 클릭');
                },
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Color(0XFFF7F7F8)),
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                  ),
                  child: CustomIcon(
                    name: 'camera',
                    size: 18,
                    color: Color(0XFF1C1B1F),
                  ),
                ),
              ),
            ),
          ],
        )
        : Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(profileImageUrl, fit: BoxFit.cover),
          ),
        );
  }
}
