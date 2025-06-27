import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project/member_icon.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';

class ProjectMemberIcons extends ConsumerWidget {
  List<UserEntity> members;
  ProjectMemberIcons({super.key, required this.members});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // 아바타 겹치기
        SizedBox(
          height: 32,
          width: 100, // 너비는 아바타 수에 따라 적절히 조절
          child: Stack(
            children: List.generate(members.length, (i) {
              return Positioned(
                left: i * 18, // 겹치는 정도 조절
                child: MemberIcon(
                  name: members[i].name,
                  imageUrl: members[i].profileImageUrl,
                ),
              );
            }),
            // ..add(
            //   // +n 동그라미
            //   Positioned(
            //     left: 3 * 18,
            //     child: Container(
            //       width: 32,
            //       height: 32,
            //       decoration: BoxDecoration(
            //         shape: BoxShape.circle,
            //         color: AppColors.primary500,
            //         border: Border.all(color: Colors.white, width: 1),
            //       ),
            //       child: Center(
            //         child: Text(
            //           '+3',
            //           style: TextStyle(
            //             fontSize: 12,
            //             fontWeight: FontWeight.w500,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ),
        ),
        // SizedBox(width: 36, height: 36, child: Icon(Icons.more_vert, size: 24)),
      ],
    );
  }
}
