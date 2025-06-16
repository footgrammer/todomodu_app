import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MemberIcon extends ConsumerWidget {
  final String? imageUrl;
  final String? name;
  MemberIcon({super.key, this.imageUrl, this.name});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool hasImage = imageUrl != null && imageUrl!.isNotEmpty;
    return CircleAvatar(
      radius: 16, // 지름 32
      backgroundColor: hasImage ? Colors.transparent : Colors.grey.shade300,
      backgroundImage:
          hasImage ? NetworkImage(imageUrl!) : null, // 이미지가 있을 때만 사용
      child:
          !hasImage
              ? Text(
                (name?.isNotEmpty ?? false) ? name![0].toUpperCase() : '?',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF28282F),
                ),
              )
              : null,
    );
  }
}
